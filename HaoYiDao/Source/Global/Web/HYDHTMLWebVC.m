//
//  HYDHomeClassifyWebVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHTMLWebVC.h"
#import <WebKit/WebKit.h>
#import "HYDNewsTopicShowModel.h"
//#import "UMSocial.h"
#import "HYDUserCollectionVC.h"

#import "HYDHealthNetRequest.h" //天狗
#import "HYDHealthModel.h"

@interface HYDHTMLWebVC ()<WKNavigationDelegate,UIAlertViewDelegate>
{
    NSString *defaultTitle;
}
@property (nonatomic,strong) WKWebView *wkView;

@end

@implementation HYDHTMLWebVC


- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [ProgressHUD dismiss];
}


- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.view.backgroundColor = [UIColor whiteColor];
    self.wkView =
    [[WKWebView alloc]initWithFrame:CGRectMake(0, 0,
                                               self.view.frame.size.width,
                                               self.view.frame.size.height - 64)];
    [self.view addSubview:_wkView];
    
    switch (_Load_Type) {
        case LoadTypeDingxiangyuan:
            [self loadDXYHtmlString];
            break;
        case LoadTypeTiangou:
            [self loadTianGouHtmlString];
            break;
        case LoadTypeNormalUrl:
            [_wkView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
            break;
        case LoadTypeString:
            [_wkView loadHTMLString:_htmlString baseURL:nil];
            break;
        default:
            break;
    }
    
    // 菊花
    [self startAnimation];
    
    [self p_setupNavigationItem];
    
}

// 收藏和分享
- (void) p_setupNavigationItem {
    
    UIToolbar *tools=[[UIToolbar alloc]initWithFrame:
                     CGRectMake(0, 0, 80 * WIDTHTSCALE, 44 * HEIGHTSCALE)];
    //解决出现的那条线
    tools.clipsToBounds = YES;
    //解决tools背景颜色的问题
    [tools setBackgroundImage:[UIImage new]forToolbarPosition:UIBarPositionAny                      barMetrics:UIBarMetricsDefault];
    [tools setShadowImage:[UIImage new]
       forToolbarPosition:UIToolbarPositionAny];
    //添加button
    NSMutableArray *buttons=[[NSMutableArray alloc]init];
    
    UIBarButtonItem *button1 =
    [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_collecte"]
                                    style: UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(collectionAct:)];
    
    UIBarButtonItem *button2 =
    [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_share"]
                                    style: UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(shareAct:)];
    
    button1.tintColor=[UIColor whiteColor];
    button2.tintColor=[UIColor whiteColor];
    UIBarButtonItem *negativeSpacer =
    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                 target:nil
                                                 action:nil];
    
    negativeSpacer.width = 10 * WIDTHTSCALE;
    
    [buttons addObject:button1];
    [buttons addObject:negativeSpacer];
    [buttons addObject:button2];
    [tools setItems:buttons
           animated:NO];
    
    UIBarButtonItem*btn=[[UIBarButtonItem alloc]initWithCustomView:tools];
    self.navigationItem.rightBarButtonItem=btn;
    
}

- (void) collectionAct:(id)sender {
    
    if (_Load_Type && self.title)
    {
        CollectionModel *model = [CollectionModel MR_createEntity];
        model.urlString = _urlString;
        model.title = self.title;
        model.loadType = _Load_Type;
        model.htmlString = _htmlString;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [ProgressHUD showSuccess:@"收藏成功"];
    }else
        [ProgressHUD showError:@"当前不可收藏"];
}

- (void) shareAct:(id)sender {
    
//    NSString *title = [NSString stringWithFormat:@"%@:%@",UMENG_SHARE_TEXT,self.title];
//
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:UMENG_APIKEY
//                                      shareText:title
//                                     shareImage:[UIImage imageNamed:@"logo_button"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,nil]
//                                       delegate:self];
    
//    if (_urlString.lastPathComponent) {
//        [[UMSocialData defaultData].urlResource setResourceType:(UMSocialUrlResourceTypeWeb)url:_urlString];
//    }else if (_htmlString.length)
//        [[UMSocialData defaultData].urlResource setResourceType:(UMSocialUrlResourceTypeWeb)url:_htmlString];
//    else {
//        [[UMSocialData defaultData].urlResource setResourceType:(UMSocialUrlResourceTypeWeb)url:APP_APPSTORE_URL];
//    }
}


- (void) loadDXYHtmlString {
    
    __block NSDictionary *dataDic = [NSDictionary dictionary];
    __block typeof(self) weakSelf = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:_urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers |
                             NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dic1 = dic[@"data"];
        
        NSArray *array = dic1[@"items"];
        dataDic = [array firstObject];
        HYDNewsTopicShowModel *model = [[HYDNewsTopicShowModel alloc]init];
        [model setValuesForKeysWithDictionary:dataDic];
        
#warning mark 替换API提供商信息
        NSString *str = [model.content stringByReplacingOccurrencesOfString:@"丁香园"
                                                                 withString:@"好医道"];
        NSString *string = [str stringByReplacingOccurrencesOfString:@"丁香医生"
                                                          withString:@"好医道"];
        [weakSelf.wkView loadHTMLString:string baseURL:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (void) loadTianGouHtmlString {
    
    [[HYDHealthNetRequest shareInstance] netRequestWithParameter:nil
                                                          Method:_urlString
                                                           Block:^(id result) {
                                                               [self p_showData:result];
                                                           } Error:^(id error) {
                                                               
                                                           }];
}

- (void) p_showData:(id)result {
    
    HYDHealthModel *model = [[HYDHealthModel alloc]init];
    [model setValuesForKeysWithDictionary:(NSDictionary *)result];
    self.title = model.title;
    [_wkView loadHTMLString:model.message baseURL:nil];
}

// 加载动画

-(void) startAnimation
{
    // 转动图片
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:
                               CGRectMake(self.view.frame.size.width / 2 - 30,
                                          self.view.frame.size.height / 2 -150,
                                          60,60)];
    
    imageView1.image = [UIImage imageNamed:@"juhua1"];
    
    imageView1.tag = 101;
    
    // 底图
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 30,self.view.frame.size.height / 2 -150, 60, 60)];
    
    imageView2.image = [UIImage imageNamed:@"juhua2"];
    
    imageView2.tag = 102;
    
    
    [self.view addSubview:imageView2];
    [self.view addSubview:imageView1];
    
    // 设置动画
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI];
    rotationAnimation.duration = 0.3;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100;
    
    [imageView1.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageView1.layer removeAllAnimations];
        [imageView1 removeFromSuperview];
        [imageView2 removeFromSuperview];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[self.view viewWithTag:101].layer removeAllAnimations];
        [[self.view viewWithTag:102] removeFromSuperview];
        [[self.view viewWithTag:101] removeFromSuperview];
    });
    
}

//显示进度滚轮指示器
-(void)showWaiting:(UIView *)parent
{
    int width = 32, height = 32;
    CGRect frame = CGRectMake(100, 200, 110, 70) ;//[parent frame]; //[[UIScreen mainScreen] applicationFrame];
    int x = frame.size.width;
    int y = frame.size.height;
    
    frame = CGRectMake((x - width) / 2, (y - height) / 2, width, height);
    
    UIActivityIndicatorView* progressInd = [[UIActivityIndicatorView alloc]initWithFrame:frame];
    
    [progressInd startAnimating];
    progressInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    frame = CGRectMake((x - 70)/2, (y - height) / 2 + height, 80, 20);
    UILabel *waitingLable = [[UILabel alloc] initWithFrame:frame];
    waitingLable.text = @"Loading...";
    waitingLable.textColor = [UIColor whiteColor];
    waitingLable.font = [UIFont systemFontOfSize:15];
    waitingLable.backgroundColor = [UIColor clearColor];
    
    frame =  CGRectMake(self.view.frame.size.width / 2 - 55, self.view.frame.size.height / 2 - 150, 110, 70) ;//[parent frame];
    UIView *theView = [[UIView alloc] initWithFrame:frame];
    theView.backgroundColor = [UIColor blackColor];
    theView.alpha = 0.5;
    theView.layer.cornerRadius = 10;
    
    [theView addSubview:progressInd];
    [theView addSubview:waitingLable];
    
    [theView setTag:9999];
    [parent addSubview:theView];
    
    
}

//消除滚动轮指示器
-(void)hideWaiting
{
    [[self.view viewWithTag:9999] removeFromSuperview];
    
}

// 加载完成，停止动画
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    /*
     NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '280%'";
     [webView evaluateJavaScript:str completionHandler:nil];
     
     NSString *bodyStyleVertical = @"document.getElementsByTagName('body')[0].style.verticalAlign = 'middle';";
     NSString *bodyStyleHorizontal = @"document.getElementsByTagName('body')[0].style.textAlign = 'left';";
     NSString *mapStyle = @"document.getElementById('mapid').style.margin = 'auto';";
     
     [webView evaluateJavaScript:bodyStyleHorizontal completionHandler:nil];
     [webView evaluateJavaScript:bodyStyleVertical completionHandler:nil];
     [webView evaluateJavaScript:mapStyle completionHandler:nil];
     */
    
    [[self.view viewWithTag:101].layer removeAllAnimations];
    [[self.view viewWithTag:102] removeFromSuperview];
    [[self.view viewWithTag:101] removeFromSuperview];
    
    
}


#pragma mark -------------- UMSocialUIDelegate
//-(void)didFinishGetUMSocialDataInViewController :(UMSocialResponseEntity *)response {
//
//    /* 根据`responseCode`得到发送结果,如果分享成功 */
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        /* 得到分享到的微博平台名 */
//        [ProgressHUD showSuccess:@"分享成功！"];
//    }
//}



@end
