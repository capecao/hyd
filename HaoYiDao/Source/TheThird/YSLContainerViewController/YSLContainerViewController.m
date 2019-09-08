//
//  YSLContainerViewController.m
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/02/10.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "YSLContainerViewController.h"
#import "YSLScrollMenuView.h"
#import "YSLMangerViewController.h"
#import "HYDNewsHotSpotVC.h"
#import "HYDNewsCategoryVC.h"

#define HYD_NEWS_CATEGORY_LISTURLSTRING @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=%@&channelType=%@&start=%d&rows=%d"

@interface YSLContainerViewController () <UIScrollViewDelegate, YSLScrollMenuViewDelegate>

{
    NSMutableArray *_selects; //记录点击过的item
    CGFloat kYSLScrollMenuViewHeight; // item高
}

@property (nonatomic, assign) CGFloat topBarHeight;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) YSLScrollMenuView *menuView;

@end

@implementation YSLContainerViewController

- (id) initWithTopBarHeight:(CGFloat)topBarHeight
     parentViewController:(UIViewController *)parentViewController
{
    self = [super init];
    if (self) {
        
        kYSLScrollMenuViewHeight = 40 * HEIGHTSCALE;
        [self p_setHoldData:parentViewController :topBarHeight];
        
    }
    
    return self;
}

- (void) p_setHoldData:(UIViewController *)parentViewController
                      :(CGFloat)topBarHeight {
    
    [parentViewController addChildViewController:self];
    [self didMoveToParentViewController:parentViewController];
    self.topBarHeight = topBarHeight;
    self.titles = [[NSMutableArray alloc] init];
    self.childControllers = [[NSMutableArray alloc] init];
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithArray:[[YSLNewsMenuManger shareInstance] findAll]];
    
#pragma mark 第一次查询数据没有数据则添加plist数据
    if (!(dataArray.count > 0)) {
        
        dataArray = [NSMutableArray array];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HYDNewsCategory"
                                                              ofType:@"plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray *array = [data valueForKey:@"channel"];
        
        for (int i = 0; i < 8; i ++) {
            NSDictionary *dic = array[i];
            NewsMenuModel *model = [NewsMenuModel MR_createEntity];
            [model setValuesForKeysWithDictionary:dic];
            [dataArray addObject:model];
#pragma mark 第一次加载的话保存至数据库
            [[YSLNewsMenuManger shareInstance] addNewsMenuModel:model];
        }
    }
    
    for (int i = 0; i < dataArray.count; i ++) {
        
        NewsMenuModel *model = dataArray[i];
        if ([model.channelName isEqualToString:@"头条"]) {
            HYDNewsHotSpotVC *vc = [[HYDNewsHotSpotVC alloc]init];
            vc.title = model.channelName;
            [_childControllers addObject:vc];

        }else {
            
            HYDNewsCategoryVC *vc = [[HYDNewsCategoryVC alloc]init];
            vc.title = model.channelName;
            vc.channelType = model.channelType;
            vc.channelId = model.channelId;
            [_childControllers addObject:vc];
        }
    }
    
    NSMutableArray *titles = [NSMutableArray array];
    for (UIViewController *vc in _childControllers) {
        [titles addObject:[vc valueForKey:@"title"]];
    }
    _titles = [titles mutableCopy];
    
#pragma mark 保证头条排在index=0
    int origin = 0;
    for (int i = 0;i < _titles.count; i++) {
        if ([_titles[i] isEqualToString:@"头条"] && [_childControllers[i] isKindOfClass:[HYDNewsHotSpotVC class]]) {
            origin = i;
        }
    }
    if (origin != 0) {
        [_titles exchangeObjectAtIndex:origin withObjectAtIndex:0];
        [_childControllers exchangeObjectAtIndex:origin withObjectAtIndex:0];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setupViews
    [self p_setupView];
}

- (void) p_setupView {
    
    if ([self.view viewWithTag:1000]) {
        [[self.view viewWithTag:1000] removeFromSuperview];
    }
    UIView *viewCover = [[UIView alloc]init];
    viewCover.tag = 1000;
    [self.view addSubview:viewCover];
    
    // ContentScrollview setup
    if (_contentScrollView) {
        [_contentScrollView removeFromSuperview];
    }
    self.contentScrollView = [[UIScrollView alloc]init];
    _contentScrollView.frame = CGRectMake(0,_topBarHeight + kYSLScrollMenuViewHeight, self.view.frame.size.width, self.view.frame.size.height - (_topBarHeight + kYSLScrollMenuViewHeight));
    _contentScrollView.backgroundColor = [UIColor clearColor];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.scrollsToTop = NO;
    [self.view addSubview:_contentScrollView];
    
    _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width * self.childControllers.count, _contentScrollView.frame.size.height);
    
    // ContentViewController setup
    for (int i = 0; i < self.childControllers.count; i++) {
        id obj = [self.childControllers objectAtIndex:i];
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)obj;
            CGFloat scrollWidth = _contentScrollView.frame.size.width;
            CGFloat scrollHeght = _contentScrollView.frame.size.height;
            controller.view.frame = CGRectMake(i * scrollWidth, 0, scrollWidth, scrollHeght);
            [_contentScrollView addSubview:controller.view];
        }
    }
    // meunView
    if (_menuView) {
        [_menuView removeFromSuperview];
    }
    self.menuView = [[YSLScrollMenuView alloc]initWithFrame:
                     CGRectMake(0, _topBarHeight,
                                self.view.frame.size.width,
                                kYSLScrollMenuViewHeight)];
    
    _menuView.backgroundColor = [UIColor clearColor];
    _menuView.delegate = self;
    _menuView.viewbackgroudColor = self.menuBackGroudColor;
    _menuView.itemfont = self.menuItemFont;
    _menuView.itemTitleColor = self.menuItemTitleColor;
    _menuView.itemIndicatorColor = self.menuIndicatorColor;
    _menuView.scrollView.scrollsToTop = NO;
    [_menuView setItemTitleArray:self.titles];
    [self.view addSubview:_menuView];
    [_menuView setShadowView];
    
    [self scrollMenuViewSelectedIndex:0];
    [self mangerItems];
}

#pragma mark -- private

- (void)setChildViewControllerWithCurrentIndex:(NSInteger)currentIndex
{
    for (int i = 0; i < self.childControllers.count; i++) {
        id obj = self.childControllers[i];
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)obj;
            if (i == currentIndex) {
                [controller willMoveToParentViewController:self];
                [self addChildViewController:controller];
                [controller didMoveToParentViewController:self];
            } else {
                [controller willMoveToParentViewController:self];
                [controller removeFromParentViewController];
                [controller didMoveToParentViewController:self];
            }
        }
    }
}
#pragma mark -- YSLScrollMenuView Delegate

- (void) scrollMenuViewSelectedIndex:(NSInteger)index
{
    [_contentScrollView setContentOffset:CGPointMake(index * _contentScrollView.frame.size.width, 0.) animated:YES];
    
    // item color
    [_menuView setItemTextColor:self.menuItemTitleColor
           seletedItemTextColor:self.menuItemSelectedTitleColor
                   currentIndex:index];
    
    [self setChildViewControllerWithCurrentIndex:index];
    
    if (index == self.currentIndex) { return; }
    self.currentIndex = index;
    
    if ([self respondsToSelector:@selector(containerViewItemIndex:currentController:)]) {
        [self containerViewItemIndex:self.currentIndex currentController:_childControllers[self.currentIndex]];
    }
}

#pragma mark -- ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat oldPointX = self.currentIndex * scrollView.frame.size.width;
    CGFloat ratio = (scrollView.contentOffset.x - oldPointX) / scrollView.frame.size.width;
    
    BOOL isToNextItem = (_contentScrollView.contentOffset.x > oldPointX);
    NSInteger targetIndex = (isToNextItem) ? self.currentIndex + 1 : self.currentIndex - 1;
    
    CGFloat nextItemOffsetX = 1.0f;
    CGFloat currentItemOffsetX = 1.0f;
    
    nextItemOffsetX = (_menuView.scrollView.contentSize.width - _menuView.scrollView.frame.size.width) * targetIndex / (_menuView.itemViewArray.count - 1);
    currentItemOffsetX = (_menuView.scrollView.contentSize.width - _menuView.scrollView.frame.size.width) * self.currentIndex / (_menuView.itemViewArray.count - 1);
    
    if (targetIndex >= 0 && targetIndex < self.childControllers.count) {
        // MenuView Move
        CGFloat indicatorUpdateRatio = ratio;
        if (isToNextItem) {
            
            CGPoint offset = _menuView.scrollView.contentOffset;
            offset.x = (nextItemOffsetX - currentItemOffsetX) * ratio + currentItemOffsetX;
            [_menuView.scrollView setContentOffset:offset animated:NO];
            
            indicatorUpdateRatio = indicatorUpdateRatio * 1;
            [_menuView setIndicatorViewFrameWithRatio:indicatorUpdateRatio isNextItem:isToNextItem toIndex:self.currentIndex];
        } else {
            
            CGPoint offset = _menuView.scrollView.contentOffset;
            offset.x = currentItemOffsetX - (nextItemOffsetX - currentItemOffsetX) * ratio;
            [_menuView.scrollView setContentOffset:offset animated:NO];
            
            indicatorUpdateRatio = indicatorUpdateRatio * -1;
            [_menuView setIndicatorViewFrameWithRatio:indicatorUpdateRatio isNextItem:isToNextItem toIndex:targetIndex];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentIndex = scrollView.contentOffset.x / _contentScrollView.frame.size.width;
    
    if (currentIndex == self.currentIndex) { return; }
    self.currentIndex = currentIndex;
    
    // item color
    [_menuView setItemTextColor:self.menuItemTitleColor
           seletedItemTextColor:self.menuItemSelectedTitleColor
                   currentIndex:currentIndex];
    
    if ([self respondsToSelector:@selector(containerViewItemIndex:currentController:)]) {
        [self containerViewItemIndex:self.currentIndex currentController:_childControllers[self.currentIndex]];
    }
    [self setChildViewControllerWithCurrentIndex:self.currentIndex];
}

#pragma mark 管理选项
- (void) mangerItems {
    
    [_menuView.editBt addTarget:self
                         action:@selector(editBtAct:)
               forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void) editBtAct:(UIButton *)sender {
    
    YSLMangerViewController *vc = [[YSLMangerViewController alloc]init];
    HYDNavigationController *nc = [[HYDNavigationController alloc]initWithRootViewController:vc];
    
    //获取通知中心单例对象
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [notification addObserver:self
                     selector:@selector(itemsChangeNotice:)
                         name:HYD_NEWSITEM_CHANGED_FLAG object:nil];

    [self presentViewController:nc animated:YES completion:nil];
    
}

-(void)itemsChangeNotice:(NSNotification *)sender{
    
    NSDictionary *userInfo = sender.userInfo;
    NSMutableArray *array = [userInfo valueForKey:HYD_NEWSITEM_USERINGO_KEY];
    
    NSMutableIndexSet *indexSet0 = [NSMutableIndexSet indexSet];
    NSMutableIndexSet *indexSet1 = [NSMutableIndexSet indexSet];
    NSMutableIndexSet *indexSet2 = [NSMutableIndexSet indexSet];
    NSInteger origin = 0;
    //取到VC和title所有index
    for (int j = 0; j < _titles.count; j ++) {
        [indexSet1 addIndex:(NSUInteger)j];
    }
    
    for (int i = 0; i < array.count; i ++) {
        NewsMenuModel *model = array[i];
        for (int j = 0; j < _titles.count; j ++) {
            
            if ([_titles[j] isEqualToString:model.channelName]) {
                // 记录未变化index
                [indexSet0 addIndex:(NSUInteger)j];
                //array中不一样的index
                [indexSet2 addIndex:(NSUInteger)i];
            }
        }
    }
    
    // 得到变化的
    [indexSet1 removeIndexes:indexSet0]; // _titlws中变化了的
    
    // 删除变化的VC和title
    [_childControllers removeObjectsAtIndexes:indexSet1];
    [_titles removeObjectsAtIndexes:indexSet1];
    
    // 添加新增的VC和title
    NSMutableArray *vcs = [NSMutableArray array];
    NSMutableArray *tits = [NSMutableArray array];

    for (int i = 0;i< array.count;i ++) {
        
        NewsMenuModel *model = array[i];
        [tits addObject:model.channelName];

        if ([model.channelName isEqualToString:@"头条"]) {
            HYDNewsHotSpotVC *vc = [[HYDNewsHotSpotVC alloc]init];
            vc.title = model.channelName;
            [vcs addObject:vc];
        }else {
        
            HYDNewsCategoryVC *vc = [[HYDNewsCategoryVC alloc]init];
            vc.title = model.channelName;
            vc.channelType = model.channelType;
            vc.channelId = model.channelId;
            [vcs addObject:vc];
        }
    }
    
    [vcs removeObjectsAtIndexes:indexSet2];
    [tits removeObjectsAtIndexes:indexSet2];
    
    [_childControllers addObjectsFromArray:vcs];
    [_titles addObjectsFromArray:tits];
    // 设置数组第一个元素
    for (int i = 0;i < _titles.count; i++) {
        
        if ([_titles[i] isEqualToString:@"头条"] && [_childControllers[i] isKindOfClass:[HYDNewsHotSpotVC class]]) {
            
            origin = i;
        }
    }
    if (origin != 0) {
        [_titles exchangeObjectAtIndex:origin withObjectAtIndex:0];
        [_childControllers exchangeObjectAtIndex:origin withObjectAtIndex:0];
    }
    
//    NSLog(@"_childControllers = %@",_childControllers);
//    NSLog(@"_titles = %@",_titles);
    
    [self p_setupView];
    
}

#pragma mark 点击事件 点击后加载
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller {
    
    controller = _childControllers[index];
    BOOL flag = true;
    if (!_selects) {
        _selects = [NSMutableArray array];
    }else
        for (NSString *number in _selects) {
            NSInteger count = [number integerValue];
            if (index == count) {
                flag = false;
            }
        }
    
    if (flag && ![controller isKindOfClass:[HYDNewsHotSpotVC class]]) {
        HYDNewsCategoryVC *vc = (HYDNewsCategoryVC *)controller;
        NSString *urlString = [NSString stringWithFormat:HYD_NEWS_CATEGORY_LISTURLSTRING,vc.channelId,vc.channelType,0,15];
        [vc p_requestNewsData:urlString];
        [vc p_requestImgsData];
    }
    
    [_selects addObject:[NSString stringWithFormat:@"%d",(int)index]];
    
}


@end
