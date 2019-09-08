//
//  HYDDiseaseListVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDDiseaseListVC.h"
#import "HYDDiseaseCommon.h"
#import "HYDAdministrativeModel.h"
#import "HYDDiseaseInfoListVC.h"

@interface HYDDiseaseListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HYDDiseaseListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self p_setNavigation];
    [self p_setupView];
    [self p_setNotice];
    [self p_setDefaultData];
}

- (void) p_setNavigation {
    
    NavItemView *navItemView2 = [[NavItemView alloc]initWithFrame:navFrame];
    [navItemView2.barButton setImage:[UIImage imageNamed:@"nav_list"]
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

- (void) p_setDefaultData {
    self.dataArray = [NSMutableArray new];
    self.title = @"内科";
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSArray *array = [NSArray arrayWithArray:[settings valueForKey:HYDDISEASELIST_STANDAR0]];
    for (NSDictionary *dic in array) {
        HYDAdministrativeModel *model = [[HYDAdministrativeModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    [_tableView reloadData];

}


- (void)p_setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0,
                                 0,
                                 self.view.bounds.size.width,
                                 self.view.bounds.size.height - 64)
                                                 style:(UITableViewStylePlain)];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


- (void) rightBarButtonItemAct:(id)sender {
    
    [self presentRightMenuViewController:nil];
}

- (void) p_setNotice {
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(p_notice:) name:HYDADMINISTRATIVENOTIFICATION object:nil];
}

- (void) p_notice:(NSNotification *)sender {
    
    self.dataArray = [NSMutableArray new];
    NSArray *array = [NSArray arrayWithArray:[sender.userInfo valueForKey:@"data"]];
    for (NSDictionary *dic in array) {
        HYDAdministrativeModel *model = [[HYDAdministrativeModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    self.title = (NSString *)[sender.userInfo valueForKey:@"title"];
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HYDAdministrativeModel *model = _dataArray[indexPath.row];
    cell.textLabel.font = HYD_font(14.f);
    cell.textLabel.text = model.dataName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDDiseaseInfoListVC *infoVC = [[HYDDiseaseInfoListVC alloc] init];
    HYDAdministrativeModel *mdoel = _dataArray[indexPath.row];
    infoVC.dataID = mdoel.dataId;
    infoVC.title = mdoel.dataName;
    infoVC.dataType = mdoel.dataType;
    [self.navigationController pushViewController:infoVC animated:YES];
}

@end
