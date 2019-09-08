//
//  YSLContainerViewController.h
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/02/10.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSLNewsMenuManger.h"

@protocol YSLContainerViewControllerDelegate <NSObject>

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller;

@end

@interface YSLContainerViewController : UIViewController

//@property (nonatomic, weak) id <YSLContainerViewControllerDelegate> delegate;

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *childControllers;

@property (nonatomic, strong) UIFont  *menuItemFont;
@property (nonatomic, strong) UIColor *menuItemTitleColor;
@property (nonatomic, strong) UIColor *menuItemSelectedTitleColor;
@property (nonatomic, strong) UIColor *menuBackGroudColor;
@property (nonatomic, strong) UIColor *menuIndicatorColor;

- (id) initWithTopBarHeight:(CGFloat)topBarHeight
       parentViewController:(UIViewController *)parentViewController;

@end
