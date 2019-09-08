//
//  HYDWeatherViewController.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomePageViewController.h"
#import "HYDHomeHeadView.h"
#import "HYDThemeItem.h"
#import "HYDHomeTopicCell.h"
#import "HYDHomeTopicModel.h"
#import "HYDHomeTopicDetailVC.h"
#import "HYDHomePageCommon.h"
#import "HYDHomeThemeVC.h"
#import "HYDHomeClassifyVC.h"
#import "HYDHomePhysicalVC.h"
#import "HYDHomeRareDiseaseVC.h"
#import "HYDHomeMedicationsVC.h"
#import "HYDSearchVC.h"
#import "HYDHomeClassifyTipsVC.h"

@interface HYDHomePageViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    int _page;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HYDHomeHeadView *header;
//@property(nonatomic,strong) UIView *searchBarView;

@end

static NSString * const reuseIdentifier = @"Cell";

@implementation HYDHomePageViewController

- (void) viewDidLoad {
    [super viewDidLoad];

    [self p_setupFeatures];
    [self p_setupSearchView];
}

- (void) p_setupSearchView {
    
    // 搜索
    /*
    self.searchBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40 * HEIGHTSCALE)];
    _searchBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_searchBarView];
    
    UITextField *searchTF = [[UITextField alloc]initWithFrame:CGRectMake(_searchBarView.frame.size.width * .12, 5 * HEIGHTSCALE, self.view.frame.size.width * .76, 30 * HEIGHTSCALE)];
    searchTF.backgroundColor = [UIColor whiteColor];
     
     searchTF.layer.borderColor = HYD_themeColor.CGColor;
     searchTF.layer.borderWidth = .5;
     searchTF.layer.masksToBounds = YES;
     searchTF.layer.cornerRadius = searchTF.size.height * .5;
     
     searchTF.textAlignment = NSTextAlignmentCenter;
     searchTF.placeholder = @"疾病，文章，药物，症状";
     searchTF.delegate = self;
     searchTF.tag = 110;
     
     [_searchBarView addSubview:searchTF];
     
     UIImageView *searchImg =
     [[UIImageView alloc]initWithFrame:
     CGRectMake(CGRectGetMaxX(searchTF.frame) - 25 * HEIGHTSCALE,
     CGRectGetMinY(searchTF.frame) + 5 * HEIGHTSCALE,
     20 * HEIGHTSCALE, 20 * HEIGHTSCALE)];
     
     searchImg.image = [UIImage imageNamed:@"icon_search_greed"];
     [_searchBarView addSubview:searchImg];
     */
#pragma mark 设置任意边角的圆角
    /*
    UIBezierPath *maskPath =
    [UIBezierPath bezierPathWithRoundedRect:searchTF.bounds
                          byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                cornerRadii:CGSizeMake(searchTF.bounds.size.height * .5,
                                                       searchTF.bounds.size.height * .5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = searchTF.bounds;
    maskLayer.path = maskPath.CGPath;
    searchTF.layer.mask = maskLayer;
    */
    
}


- (void) rightBarButtonItemAction:(UIBarButtonItem *)sender {
    
    HYDSearchVC *vc = [[HYDSearchVC alloc]init];
    [self presentViewController:[[HYDNavigationController alloc]initWithRootViewController:vc]
                       animated:YES completion:nil];
}

- (void) p_setupFeatures {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0, 0,
                                 [UIScreen mainScreen].bounds.size.width,
                                 [UIScreen mainScreen].bounds.size.height - 113
                                 )
                                                 style:UITableViewStylePlain];
    [_tableView registerClass:[HYDHomeTopicCell class] forCellReuseIdentifier:reuseIdentifier];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    self.dataArray = [NSMutableArray array];

    [self p_requestData];
    [self p_refresh];
    _page = 1;
}

- (void) p_setupThemeItems {
    
    for (int i = 0; i < 6; i ++) {
        
        HYDThemeItem *item = [_header viewWithTag:1000 + i];
        item.button.tag = 200 + i;
        [item.button addTarget:self action:@selector(HYDThemeItemAct:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
}

- (void) p_setupClassifyItems {
   
    for (int i = 0; i < 10; i ++) {
        
        HYDClassifyItme *item = [_header viewWithTag:2000 + i];
        item.button.tag = 400 + i;
        [item.button addTarget:self action:@selector(HYDClassifyItmeAct:) forControlEvents:(UIControlEventTouchUpInside)];
    }

}

- (void) HYDThemeItemAct:(UIButton *)sender {
    
    NSArray *sections = @[@"8",@"3",@"4",@"5",@"9",@"7"];
    NSArray *titles = @[@"母婴之家",@"儿童健康",@"解码男人",@"女性健康圈",@"慢性病时间",@"聚焦大病"];
    HYDHomeThemeVC *vc = [[HYDHomeThemeVC alloc]init];
    vc.title = titles[sender.tag - 200];
    vc.URL = [NSString stringWithFormat:HOME_THEME_SECTION_URL,sections[sender.tag - 200]];
    [self presentViewController:[[HYDNavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
}

- (void) HYDClassifyItmeAct:(UIButton *)sender {
    
    NSInteger count = sender.tag - 400 - 3;
    if (count >= 0 && count < 6) {
        
        NSArray *sections = @[@"17",@"13",@"16",@"14",@"12",@"15"];
        NSArray *titles = @[@"非处方用药",@"孕妇哺乳期妇女用药",@"妇科用药",@"儿童用药",@"男科用药",
                            @"老人用药"];
        HYDHomeClassifyVC *vc = [[HYDHomeClassifyVC alloc]init];
        vc.title = titles[count];
        vc.URL = [NSString stringWithFormat:HOME_CLASSIFY_CLASSLIST_URL,sections[count]];
        [self presentViewController:[[HYDNavigationController alloc]initWithRootViewController:vc]
                           animated:YES completion:nil];
        
    }
    else if (count == -1) {
        HYDHomeRareDiseaseVC *vc = [[HYDHomeRareDiseaseVC alloc]init];
        [self presentViewController:[[HYDNavigationController alloc]initWithRootViewController:vc]
                           animated:YES completion:nil];
    }
    else if (count == -2) {
        HYDHomePhysicalVC *vc = [[HYDHomePhysicalVC alloc]init];
        [self presentViewController:[[HYDNavigationController alloc]initWithRootViewController:vc]
                           animated:YES completion:nil];
    }
    else if (count == -3) {
        HYDHomeMedicationsVC *vc = [[HYDHomeMedicationsVC alloc]init];
        [self presentViewController:[[HYDNavigationController alloc]initWithRootViewController:vc]
                           animated:YES completion:nil];
    }else if (count == 6) {
        HYDHomeClassifyTipsVC *vc = [[HYDHomeClassifyTipsVC alloc]init];
        [self presentViewController:[[HYDNavigationController alloc]initWithRootViewController:vc]
                           animated:YES completion:nil];
    }
    
}

- (void)p_requestData {
    
    __block NSDictionary *dictionary = [NSDictionary new];
    __weak typeof(self) weakself = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString = [NSString stringWithFormat:topicListRefreshUrl,_page];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"items"]];
        
        if (array.count > 0) {
            
            for (NSDictionary *dic in array) {
                
                HYDHomeTopicModel *model = [[HYDHomeTopicModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArray addObject:model];
            }
            [_tableView.mj_footer endRefreshing];
            [weakself.tableView reloadData];
            
        }else {
            
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

// 下拉刷新 ，上拉加载
- (void) p_refresh {
    
    _tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        if (_page < 10)
            _page ++;
        [self p_requestData];
        
    }];
    
}


#pragma mark <UITableViewDataSource>

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHomeTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    HYDHomeTopicModel *model = _dataArray[indexPath.row];
    cell.titleLabel.text = model.name;
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_small]];
    
    return cell;
}

#pragma mark <UITableViewDelegate>

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UIScreen mainScreen].bounds.size.height * .3;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHomeTopicModel *model = _dataArray[indexPath.row];
    HYDHomeTopicDetailVC *TDVC = [[HYDHomeTopicDetailVC alloc]init];
    TDVC.model = model;
    [self presentViewController:[[HYDNavigationController alloc]initWithRootViewController:TDVC] animated:YES completion:nil];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [UIScreen mainScreen].bounds.size.height;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (_header) {
        [_header removeFromSuperview];
    }
    self.header = [[HYDHomeHeadView alloc]initWithFrame:
                               CGRectMake(0, 0,
                                          [UIScreen mainScreen].bounds.size.width,
                                          [UIScreen mainScreen].bounds.size.height)];
    [self p_setupThemeItems];
    [self p_setupClassifyItems];
    
    return  _header;
}

/* 去粘性 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = [UIScreen mainScreen].bounds.size.height;//设置你footer高度
    
    if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >=0 ) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    }
    else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //    _searchBarView.alpha = 1;
    [self rightBarButtonItemAction:nil];

    // 不弹出键盘
    return NO;
}


@end
