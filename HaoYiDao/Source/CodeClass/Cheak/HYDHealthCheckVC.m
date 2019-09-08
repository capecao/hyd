//
//  HYDHealthCheckVC.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/22.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "HYDHealthCheckVC.h"
#import "HYDHealthCheckView.h"
#import "HYDHealthClassifyVC.h"

#import "HYDDrugListVC.h"
#import "HYDExamineListVC.h"
#import "HYDSelfExaminationListVC.h"
#import "HYDDiseaseListVC.h"
#import "HYDAdministrativeListVC.h"
#import "HYDHealthClassifyVC.h"

#import <RESideMenu/RESideMenu.h>
#import "CustomPresentation.h"
#import "HYDHealthCheckTransition.h"

#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface HYDHealthCheckVC ()<RESideMenuDelegate,UIViewControllerTransitioningDelegate,AMapSearchDelegate>
{
    UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
    CGFloat percent;
    NSString *citycode; // 城市编码
}
@property (nonatomic,strong) RESideMenu *sideMenu;
@property (nonatomic,strong) HYDHealthCheckView *checkView;
@property (nonatomic,strong) AMapSearchAPI *search;
@property (nonatomic,strong) AMapLocationManager *locationManager; //定位坐标

@end

@implementation HYDHealthCheckVC

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = self;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.checkView = [[HYDHealthCheckView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _checkView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getLocationInfo];

    self.modalPresentationStyle = UIModalPresentationCustom;
    
    [_checkView.dismissBt addTarget:self
                             action:@selector(dismissBtAct:)
                   forControlEvents:UIControlEventTouchUpInside];
    
    [_checkView.diseaseBt addTarget:self
                             action:@selector(switchToItemvcAct:)
                   forControlEvents:UIControlEventTouchUpInside];
    [_checkView.sectionBt addTarget:self
                             action:@selector(switchToItemvcAct:)
                   forControlEvents:UIControlEventTouchUpInside];
    [_checkView.selfcheckBt addTarget:self
                               action:@selector(switchToItemvcAct:)
                     forControlEvents:UIControlEventTouchUpInside];
    [_checkView.drugBt addTarget:self
                          action:@selector(switchToItemvcAct:)
                forControlEvents:UIControlEventTouchUpInside];
    [_checkView.infoBt addTarget:self
                          action:@selector(switchToItemvcAct:)
                forControlEvents:UIControlEventTouchUpInside];
    [_checkView.knownBt addTarget:self
                          action:@selector(switchToItemvcAct:)
                forControlEvents:UIControlEventTouchUpInside];
    [_checkView.askBt addTarget:self
                          action:@selector(switchToItemvcAct:)
                forControlEvents:UIControlEventTouchUpInside];
    [_checkView.bookBt addTarget:self
                          action:@selector(switchToItemvcAct:)
                forControlEvents:UIControlEventTouchUpInside];

}

/*获取定位信息*/
- (void) getLocationInfo {
        
    self.locationManager = [[AMapLocationManager alloc]init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES
                                       completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
            citycode = @"1001010";
        }
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            citycode = regeocode.adcode;
            [self weartherConfigeration];
        }
    }];
    
}

- (void) weartherConfigeration {
    
    // 初始化AMapSearchAPI
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    AMapWeatherSearchRequest *request = [[AMapWeatherSearchRequest alloc] init];
    request.city = citycode;
    //AMapWeatherTypeLive为实时天气；AMapWeatherTypeForecase为预报天气
    request.type = AMapWeatherTypeLive;
    
    [self.search AMapWeatherSearch:request];
    
}

/**
 跳转 疾病 科室 自查 药品
 
 @param sender button
 */
- (void) switchToItemvcAct:(UIButton *)sender {
    
    HYDNavigationController *nc;
    switch (sender.tag) {
        case 1000:
        {
            [self P_setupRESideMenu];
        }
            break;
        case 1001:
        {
            HYDExamineListVC *vc = [[HYDExamineListVC alloc]init];
            nc = [[HYDNavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nc animated:YES completion:nil];
        }
            break;
        case 1002:
        {
            HYDSelfExaminationListVC *vc = [[HYDSelfExaminationListVC alloc]init];
            nc = [[HYDNavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nc animated:YES completion:nil];
        }
            break;
        case 1003:
        {
            HYDDrugListVC *vc = [[HYDDrugListVC alloc]init];
            nc = [[HYDNavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nc animated:YES completion:nil];
        }
            break;
        case 1004:
        {
            HYDHealthClassifyVC *vc = [[HYDHealthClassifyVC alloc]init];
            vc.tag = 1;
            nc = [[HYDNavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nc animated:YES completion:nil];
        }
            break;
        case 1005:
        {
            HYDHealthClassifyVC *vc = [[HYDHealthClassifyVC alloc]init];
            vc.tag = 2;
            nc = [[HYDNavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nc animated:YES completion:nil];
        }
            break;

        case 1006:
        {
            HYDHealthClassifyVC *vc = [[HYDHealthClassifyVC alloc]init];
            vc.tag = 3;
            nc = [[HYDNavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nc animated:YES completion:nil];
        }
            break;
        case 1007:
        {
            HYDHealthClassifyVC *vc = [[HYDHealthClassifyVC alloc]init];
            vc.tag = 4;
            nc = [[HYDNavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nc animated:YES completion:nil];
        }
            break;

        default:
            break;
    }
    
}

// 抽屉效果
- (void) P_setupRESideMenu {
    
    if (_sideMenu) {
        [_sideMenu removeFromParentViewController];
    }
    
    HYDDiseaseListVC *listVC = [[HYDDiseaseListVC alloc]init];
    HYDNavigationController *NC = [[HYDNavigationController alloc]initWithRootViewController:listVC];
    self.sideMenu = [[RESideMenu alloc]initWithContentViewController:NC
                                              leftMenuViewController:nil
                                             rightMenuViewController:[[HYDAdministrativeListVC alloc]init]];
    
    _sideMenu.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    _sideMenu.delegate = self;
    _sideMenu.contentViewShadowColor = [UIColor whiteColor];
    _sideMenu.contentViewShadowOffset = CGSizeMake(0, 0);
    _sideMenu.contentViewShadowOpacity = .5;
    _sideMenu.contentViewShadowRadius = 12;
    _sideMenu.contentViewShadowEnabled = YES;
    
    [self presentViewController:_sideMenu animated:YES completion:nil];
}

- (void) dismissBtAct:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        sender.transform = CGAffineTransformMakeRotation(M_PI_4);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - <UIViewControllerTransitioningDelegate>
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    
    CustomPresentation *presentation = [[CustomPresentation alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    return presentation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    HYDHealthCheckTransition * present = [[HYDHealthCheckTransition alloc]initWithBool:YES];
    return present;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController
:(UIViewController *)dismissed{
    
    if (dismissed) {
        HYDHealthCheckTransition * present = [[HYDHealthCheckTransition alloc]initWithBool:NO];
        return present;
    }else{
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    if (animator) {
        return percentDrivenInteractiveTransition;
    }else{
        return nil;
    }
}

// AMapSearchDelegate
- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response
{
    //解析response获取天气信息，具体解析见 Demo
    AMapLocalWeatherLive *live = [response.lives firstObject];
    
    NSString *str1 = [NSString stringWithFormat:@"%@",live.city];
    NSMutableAttributedString * attrStr1 = [[NSMutableAttributedString alloc] initWithString:str1];
    [attrStr1 addAttribute: NSFontAttributeName value: HYD_font_MEDIUM(14.f) range: NSMakeRange(0, attrStr1.length)];
    
    NSString *str2 = [NSString stringWithFormat:@"%@ %@℃",live.weather,live.temperature];
    NSMutableAttributedString * attrStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
    [attrStr2 addAttribute: NSFontAttributeName
                     value: HYD_font(16.f)
                     range: NSMakeRange(0, attrStr2.length)];
    [attrStr2 addAttribute: NSForegroundColorAttributeName
                     value: HYD_themeColor
                     range: NSMakeRange(0, attrStr2.length)];
    
    NSString *str3 = [NSString stringWithFormat:@"%@风 %@级",live.windDirection,live.windPower];
    NSMutableAttributedString * attrStr3 = [[NSMutableAttributedString alloc] initWithString:str3];
    [attrStr3 addAttribute: NSFontAttributeName
                     value: HYD_font(14.f)
                     range: NSMakeRange(0, attrStr3.length)];
    [attrStr3 addAttribute: NSForegroundColorAttributeName
                     value: [UIColor orangeColor]
                     range: NSMakeRange(0, attrStr3.length)];
    
    _checkView.cityLab.attributedText = attrStr1;
    _checkView.weatherLab.attributedText = attrStr2;
    _checkView.windLab.attributedText = attrStr3;

}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

@end
