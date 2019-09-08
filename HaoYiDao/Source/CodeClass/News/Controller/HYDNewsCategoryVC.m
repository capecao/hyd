//
//  HYDCategoryVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNewsCategoryVC.h"
#import "HYDNewsCommon.h"
#import "HYDNewsListCell.h"
#import "HYDNewsListModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "HYDNetWorkinf_Helper.h"
#import "SDCycleScrollView.h"

@interface HYDNewsCategoryVC ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{
    int _start;
    int _rows;
    CGFloat _tableViewHeaderHeight;
}

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *imgesArray;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSString *httpUrl;

@property (nonatomic,strong) NSString *circleImgsUrl;

@end

@implementation HYDNewsCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _start = 0;
    _rows = 15;
    _tableViewHeaderHeight = self.view.bounds.size.height * .3;
    self.dataArray = [NSMutableArray array];
    self.httpUrl = [NSString stringWithFormat:HYD_NEWS_CATEGORY_LISTURLSTRING,_channelId,_channelType,_start,_rows];
    self.circleImgsUrl = [NSString stringWithFormat:HYD_NEWS_CATAEGPRY_LISTCIRCLE,_channelId,_channelType];
    
    
    [self p_setupTableView];
    //    [self p_requestImgsData];
    //    [self p_requestNewsData:_httpUrl];
    [self p_refreshNews];
    
}


- (void) p_setupTableView {
    
    // 设置滚动高度
    CGRect frame = CGRectMake(0,0,self.view.bounds.size.width,
                              self.view.bounds.size.height - 113 - 40 * HEIGHTSCALE);
    self.tableView = [[UITableView alloc]initWithFrame:frame
                                                 style:(UITableViewStylePlain)];
    
    [_tableView registerClass:[HYDNewsListCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void) p_requestImgsData {
    
    self.imgesArray = [NSMutableArray array];
    __block NSDictionary *dictionary = [NSDictionary new];
    NSLog(@"_circleImgsUrl = %@",_circleImgsUrl);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager GET:_circleImgsUrl
          parameters:nil
            progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:NSJSONReadingMutableContainers |
                              NSJSONReadingMutableLeaves
                                                               error:nil];
                if (dictionary)
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
                        NSArray *array = (NSArray *)[dict valueForKey:@"channelinfoList"];
                        if (array.count > 0)
                            for (NSDictionary *dic in array) {
                                
                                HYDNewsListModel *model = [[HYDNewsListModel alloc]init];
                                [model setValuesForKeysWithDictionary:dic];
                                if (model.pic.length && model.dataTitle.length)                             [_imgesArray addObject:model];
                            }
                        
                        if (!_imgesArray.count) {
                            _tableViewHeaderHeight = 0;
                        }
                        
                        [_tableView reloadData];
                    });
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [ProgressHUD showError:@"网络中断，请稍后再试"];
            }];
    });
}

- (void) p_requestNewsData:(NSString *)urlString {
    
    __block NSDictionary *dictionary = [NSDictionary new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager POST:urlString
           parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
               
           } progress:^(NSProgress * _Nonnull uploadProgress) {
               
               
           } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               
               dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers |
                             NSJSONReadingMutableLeaves
                                                              error:nil];
               
               if (dictionary)
                   dispatch_async(dispatch_get_main_queue(), ^{
                       
                       NSDictionary *dict = (NSDictionary *)[dictionary valueForKey:@"data"];
                       NSArray *array = (NSArray *)[dict valueForKey:@"channelinfoList"];
                       if (array.count) {
                           for (NSDictionary *dic in array) {
                               
                               HYDNewsListModel *model = [[HYDNewsListModel alloc]init];
                               [model setValuesForKeysWithDictionary:dic];
                               [_dataArray addObject:model];
                           }
                           
                           [self.tableView.mj_footer endRefreshing];
                           [self.tableView.mj_header endRefreshing];
                           [_tableView reloadData];
                       }
                       
                       else {
                           
                           [self.tableView.mj_footer endRefreshingWithNoMoreData];
                       }
                   });
               
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               
               [ProgressHUD showError:@"网络中断，请稍后再试"];
               
           }];
    });
}


// 下拉刷新 ，上拉刷新没必要

- (void) p_refreshNews {
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _start += _rows;
        _rows += 15;
        NSString *urlString = [NSString stringWithFormat:HYD_NEWS_CATEGORY_LISTURLSTRING,_channelId,_channelType,_start,_rows];
        
        [self p_requestNewsData:urlString];
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self p_requestImgsData];
        NSString *urlString = [NSString stringWithFormat:HYD_NEWS_CATEGORY_LISTURLSTRING,_channelId,_channelType,_start,_rows];
        [self p_requestNewsData:urlString];
        
    }];
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    HYDNewsListModel *model = _dataArray[indexPath.row];
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]
                          placeholderImage:[UIImage imageNamed:@"logo_button"]];
    cell.titleLabel.text = model.dataTitle;
    cell.introductionLabel.text = model.content;
    
    return cell;
    
}

// 点击事件 web展示
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHTMLWebVC *webVC = [[HYDHTMLWebVC alloc]init];
    HYDNewsListModel *model = _dataArray[indexPath.row];
    webVC.urlString = [itemClickedUrl stringByAppendingString:model.dataId];
    webVC.title = model.dataTitle;
    webVC.Load_Type = LoadTypeNormalUrl;
    HYDNavigationController *nc = [[HYDNavigationController alloc]initWithRootViewController:webVC];
    [nc.logoImageView removeFromSuperview];
    
    [self presentViewController:nc
                       animated:YES
                     completion:nil];
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80 * HEIGHTSCALE;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return _tableViewHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (_imgesArray.count) {
        CGRect frame = CGRectMake(0, 0, _tableView.frame.size.width, _tableViewHeaderHeight);
        UIView *header = [[UIView alloc]initWithFrame:frame];
        header.backgroundColor = [UIColor whiteColor];
        
        NSMutableArray *imgs = [NSMutableArray array];
        NSMutableArray *tits = [NSMutableArray array];
        for (HYDNewsListModel *model in _imgesArray) {
            [imgs addObject:[NSURL URLWithString:model.pic]];
            [tits addObject:model.dataTitle];
        }
        
        // 创建带标题的图片轮播器
        CGRect frame0 = CGRectMake(0,0,
                                   self.view.bounds.size.width,
                                   _tableViewHeaderHeight - 20 * HEIGHTSCALE);
        SDCycleScrollView *cycleScrollView =
        [SDCycleScrollView cycleScrollViewWithFrame:frame0
                                     imageURLsGroup:imgs];
        
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.delegate = self;
        cycleScrollView.titlesGroup = tits;
        cycleScrollView.autoScrollTimeInterval = 2.5;
        [header addSubview:cycleScrollView];
        CGRect frame1= CGRectMake(5 * WIDTHTSCALE,
                                  CGRectGetMaxY(cycleScrollView.frame) + 2.5 * HEIGHTSCALE,
                                  15 * HEIGHTSCALE,15 * HEIGHTSCALE);
        UIImageView *newImage = [[UIImageView alloc]initWithFrame:frame1];
        newImage.image = [UIImage imageNamed:@"iconfont-broadcast"];
        [header addSubview:newImage];
        
        return header;
    }
    
    return nil;
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    HYDHTMLWebVC *webVC = [[HYDHTMLWebVC alloc]init];
    HYDNewsListModel *model = _imgesArray[index];
    webVC.urlString = [itemClickedUrl stringByAppendingString:model.dataId];
    webVC.title = model.dataTitle;
    webVC.Load_Type = LoadTypeNormalUrl;
    [self presentViewController:[[HYDNavigationController alloc]initWithRootViewController:webVC]
                       animated:YES
                     completion:nil];
}

/* 去scrollview粘性 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = self.view.bounds.size.height * .3;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
}





@end
