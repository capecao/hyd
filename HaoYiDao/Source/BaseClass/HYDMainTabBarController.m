//
//  MainTabBarController.m
//  BoundaryView
//
//  Created by wangxiaoyi on 15/7/26.
//  Copyright (c) 2015年 cape. All rights reserved.
//

#import "HYDMainTabBarController.h"
#import "HYDNearbyViewController.h"
#import "HYDHomePageViewController.h"
#import "HYDNewsViewController.h"
#import "HYDHealthCheckVC.h"
#import "HYDNavigationController.h"
#import "HYDNavigationController.h"
#import "HYDMedicationWarring.h"
#import "HYDUserCenterVC.h"
#import "HYDBAIDUWebVC.h"
#import "CustomTabBar.h"

@interface HYDMainTabBarController ()

@end

@implementation HYDMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*用药提醒*/
    [[HYDMedicationWarring shareInstance] IsRequestWarrings];
    
    [self p_setupItem];
}

- (void) p_setupItem {
    
    [[UITabBarItem appearance]
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorwithHexString:@"#74787C"],NSForegroundColorAttributeName,HYD_font(11.f),NSFontAttributeName, nil]
     forState:UIControlStateNormal]; // 未选颜色
    
    [[UITabBarItem appearance]
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HYD_themeColor,NSForegroundColorAttributeName,HYD_font(11.f),NSFontAttributeName, nil]
     forState:UIControlStateSelected]; // 选中颜色
    
    CustomTabBar *tabBar = [[CustomTabBar alloc]initWithFrame:self.tabBar.frame];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    tabBar.clickBlock = ^(){
        HYDHealthCheckVC *checkVC = [[HYDHealthCheckVC alloc]init];
        [self presentViewController:checkVC animated:YES completion:nil];
        
    };

    NSArray *titles =  @[@"主页",@"资讯",@"附近",@"我的"];
    NSArray *images =  @[@"tabhome_gray_normal",@"tabinfo_gray_normal",@"tabnear_gray_normal",@"tabuser_gray_normal"];
    NSArray *images_selected =  @[@"tabhome_blue_selected",@"tabinfo_blue_selected",@"tabnear_blue_selected",@"tabuser_blue_selected"];
    
    HYDHomePageViewController *homePageVC = [[HYDHomePageViewController alloc]init];
    HYDNewsViewController *newsVC = [[HYDNewsViewController alloc]init];
    HYDNearbyViewController *nearbyVC = [[HYDNearbyViewController alloc]init];
    HYDUserCenterVC *userVC = [[HYDUserCenterVC alloc]init];
    
    NSArray *vcs = @[homePageVC,newsVC,nearbyVC,userVC];
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    for (int i = 0; i  < titles.count; i ++) {
        
        UIViewController *currentVC =  vcs[i];
        currentVC.tabBarItem.image = [UIImage imageNamed:images[i]];
        UIImage *selectImage =  [UIImage imageNamed:images_selected[i]];
        selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        currentVC.tabBarItem.selectedImage = selectImage;
        currentVC.tabBarItem.title =titles[i];
        
        currentVC.title = titles[i];
        HYDNavigationController * nc = [[HYDNavigationController alloc] initWithRootViewController:currentVC];
        [nc hidden];
        [nc preferredStatusBarStyle];
        [viewControllers addObject:nc];
        
    }
    
    self.viewControllers = viewControllers;
    
}

@end
