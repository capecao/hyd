//
//  HYDNewsMangerVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/13.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNewsMangerVC.h"

@implementation HYDNewsMangerVC

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_setupNavigationItem];
}

- (void) p_setupNavigationItem {
    
    NavItemView *navItemView1 = [[NavItemView alloc]initWithFrame:navFrame];
    [navItemView1.barButton setImage:[UIImage imageNamed:@"icon_close"]
                            forState:(UIControlStateNormal)];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:navItemView1];
    UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                        target:nil
                                        action:nil];
    
    negativeSpacer1.width = negativeSpace;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer1, item1];
    
    [navItemView1.barButton addTarget:self
                               action:@selector(leftBarButtonItemAction:)
                     forControlEvents:(UIControlEventTouchUpInside)];
}

- (void) leftBarButtonItemAction:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
