//
//  HYDNavigationController.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNavigationController.h"
#import "HYDTitleView.h"

@interface HYDNavigationController ()

@property (nonatomic,strong) NavItemView *navItemView;
@end

@implementation HYDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置背景
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"]
                             forBarMetrics:UIBarMetricsDefault];
    
    //设置标题字体
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    [barAttrs setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self.navigationBar setTitleTextAttributes:barAttrs];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}


//拦截Push统一设置返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem == nil &&
        !([self.viewControllers count] > 1))
    {
        viewController.navigationItem.leftBarButtonItems = [self creatDismissBarButtonItem];
    }else {
        viewController.navigationItem.leftBarButtonItems = [self creatPushedBarButtonItem];

    }
}

-(void) hidden
{
    [_navItemView setHidden:YES];
}

// 自定义返回按钮
- (NSArray *) creatDismissBarButtonItem
{
    // 添加logo
    if (_logoImageView) {
        [_logoImageView removeFromSuperview];
    }
    self.logoImageView = [[UIImageView alloc]initWithFrame:
                          CGRectMake(self.navigationBar.bounds.size.width * .1,
                                     0,
                                     self.navigationBar.bounds.size.width * .2,
                                     self.navigationBar.bounds.size.height)];
    
    _logoImageView.image = [UIImage imageNamed:@"navbar_logo"];
    [self.navigationBar addSubview:_logoImageView];
    
    if (_navItemView) {
        [_navItemView removeFromSuperview];
    }
    self.navItemView = [[NavItemView alloc]initWithFrame:navFrame];
    [_navItemView.barButton setImage:[UIImage imageNamed:@"icon_close"]
                            forState:(UIControlStateNormal)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:_navItemView];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil
                                       action:nil];
    
    negativeSpacer.width = negativeSpace;
    [_navItemView.barButton addTarget:self
                               action:@selector(leftBarButtonItemAct:)
                     forControlEvents:(UIControlEventTouchUpInside)];
    
    return @[negativeSpacer, item];
}

- (NSArray *) creatPushedBarButtonItem
{
    if (_logoImageView) {
        [_logoImageView removeFromSuperview];
    }
    
    if (_navItemView) {
        [_navItemView removeFromSuperview];
    }
    self.navItemView = [[NavItemView alloc]initWithFrame:navFrame];
    [_navItemView.barButton setImage:[UIImage imageNamed:@"navc_back@2x"]
                            forState:(UIControlStateNormal)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:_navItemView];
    UIBarButtonItem *negativeSpacer =
    [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                 target:nil
                                                 action:nil];
    
    negativeSpacer.width = negativeSpace;
    [_navItemView.barButton addTarget:self
                                action:@selector(leftBarItemPopAct:)
                      forControlEvents:(UIControlEventTouchUpInside)];
    
    return @[negativeSpacer, item];
}


// 返回按钮事件
-(void) leftBarButtonItemAct:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 返回按钮事件
-(void) leftBarItemPopAct:(UIButton *)sender
{
    [self popViewControllerAnimated:YES];

}

// 重写状态栏显示方法
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}

@end
