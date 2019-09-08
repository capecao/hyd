//
//  HYDNewsViewController.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNewsViewController.h"
#import "YSLContainerViewController.h"
#import "HYDNewsHotSpotVC.h"
#import "HYDNewsCategoryVC.h"
#import "HYDNewsCommon.h"
#import "HYDNewsMangerVC.h"

@interface HYDNewsViewController ()

@property (nonatomic,strong) NSMutableArray *plistArray;
@property (nonatomic,strong) NSMutableArray *VCs;
@property (nonatomic,strong) NSMutableArray *selects;

@end

@implementation HYDNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupSubVC];

}

- (void) p_setupNavigationItem {
    
    NavItemView *navItemView2 = [[NavItemView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [navItemView2.barButton setImage:[UIImage imageNamed:@"setting_center"]
                            forState:(UIControlStateNormal)];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:navItemView2];
    UIBarButtonItem *negativeSpacer2 = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                        target:nil
                                        action:nil];
    
    negativeSpacer2.width = negativeSpace;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer2, item2];
    
    [navItemView2.barButton addTarget:self
                               action:@selector(rightBarButtonItemAct:)
                     forControlEvents:(UIControlEventTouchUpInside)];

}

- (void) rightBarButtonItemAct:(id)sender {
    
    
}

/*设置滑动页面*/
- (void) p_setupSubVC {
    
#pragma mark 读取plist
/*
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HYDNewsCategory" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    self.plistArray = [NSMutableArray array];
    NSArray *array = [data valueForKey:@"channel"];
    
    for (NSDictionary *dic in array) {
        HYDNewsCategoryModel *model = [[HYDNewsCategoryModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [_plistArray addObject:model];
    }
    
    self.VCs = [NSMutableArray array];
    for (int i = 0; i < _plistArray.count; i ++) {
        
        HYDNewsCategoryModel *model = _plistArray[i];
        if (i == 0) {
            HYDNewsHotSpotVC *vc = [[HYDNewsHotSpotVC alloc]init];
            vc.title = model.channelName;
            [_VCs addObject:vc];

        }else {
            
            HYDNewsCategoryVC *vc = [[HYDNewsCategoryVC alloc]init];
            
            vc.title = model.channelName;
            vc.channelType = model.channelType;
            vc.channelId = model.channelId;
            [_VCs addObject:vc];

        }
    }
    */
#pragma 修改新闻页面高度
    float statusHeight = 0.f;
    float navigationHeight = 0.f;
    float height = statusHeight + navigationHeight;
    YSLContainerViewController *containerVC =
    [[YSLContainerViewController alloc] initWithTopBarHeight:height
                                         parentViewController:self];
    
    self.selects = [NSMutableArray arrayWithObjects:@"0", nil];
        
    [self.view addSubview:containerVC.view];
}


@end
