//
//  HYDNearbyListVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/6/2.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNearbyListVC.h"
#import "HYDNearbyListCell.h"
#import "HYDNearby_briefModel.h"
#import "HYDNearbyHospitalVC.h"
#import "HYDNearbyDrugStoreVC.h"
#import "HYDNearbyCommon.h"
#import "HYDDistrictHospitalsVC.h"

@interface HYDNearbyListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HYDNearbyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_setupNavigationItem];
    [self p_setupTableView];
    [self p_refreshData];
}

- (void) p_setupNavigationItem {
    
    NavItemView *navItemView1 = [[NavItemView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [navItemView1.barButton setImage:[UIImage imageNamed:@"searchBar"]
                            forState:(UIControlStateNormal)];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:navItemView1];
    UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                        target:nil
                                        action:nil];
    
    negativeSpacer1.width = negativeSpace;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer1, item1];
    
    [navItemView1.barButton addTarget:self
                               action:@selector(rightItemAct:)
                     forControlEvents:(UIControlEventTouchUpInside)];
}

- (void) rightItemAct:(id)sender {
    
    HYDDistrictHospitalsVC *vc = [[HYDDistrictHospitalsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void) p_setupTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0, 0,
                                 self.view.bounds.size.width,
                                 self.view.bounds.size.height - 64)
                                                 style:(UITableViewStylePlain)];
    
    [_tableView registerClass:[HYDNearbyListCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void) p_refreshData {
    
    NSString *httpUrl = @"";
    if ([_type isEqualToString:@"0"]) {
        httpUrl = HYDNEARBYTIANGOUHOSPITAL;
    }else if ([_type isEqualToString:@"1"]) {
        httpUrl = HYDNEARBYTIANGOUDRUGSTORE;
    }
    __block int page = 1;
    __block int rows = 30;

    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        NSString *httpArg = [NSString stringWithFormat:@"x=%@&y=%@&page=%d&rows=%d",_longitude,_latitude,page,rows];
        NSString *urlString = [[NSString alloc]initWithFormat: @"%@?%@",httpUrl, httpArg];
        [self p_resuestData:urlString];
        
    }];
}

- (void) p_resuestData:(NSString *)urlString {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:TNGOU_APIKEY forHTTPHeaderField:@"apikey"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"text/xml"] forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictionary = [NSDictionary dictionary];
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers |
                      NSJSONReadingMutableLeaves error:nil];
        NSArray *array = [dictionary valueForKey:@"tngou"];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                
                HYDNearby_briefModel *model = [[HYDNearby_briefModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                //1.将两个经纬度点转成投影点
                CLLocationCoordinate2D location = CLLocationCoordinate2DMake([model.y floatValue],[model.x floatValue]);
                MAMapPoint point1 = MAMapPointForCoordinate(location);
                MAMapPoint point2 = MAMapPointForCoordinate
                (CLLocationCoordinate2DMake([_latitude doubleValue],
                                            [_longitude doubleValue]));
                //2.计算距离
                CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
                model.distance = [NSString stringWithFormat:@"距离: %.2f km",distance / 1000];
                [_lists addObject:model];
            }
            [_tableView.mj_footer endRefreshing];
            [_tableView reloadData];
            
        }else {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _lists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDNearbyListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HYDNearby_briefModel *model = _lists[indexPath.row];
    
    cell.nameLale.text = model.name;
    if (model.business.length > 0)
        cell.introLabel.text = model.business;
    else
        cell.introLabel.text = [NSString stringWithFormat:@"%@  %@",model.mtype,model.nature];
    
    cell.distanceLabel.text = model.distance;
    NSString *imgString = [NSString stringWithFormat:@"http://tnfs.tngou.net/img%@",model.img];
    [cell.imgImageView sd_setImageWithURL:[NSURL URLWithString:imgString]
                         placeholderImage:[UIImage imageNamed:@"logo_button"]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDNearby_briefModel *model = _lists[indexPath.row];

    if ([_type isEqualToString:@"0"]) {
        
        HYDNearbyHospitalVC *hosVC = [[HYDNearbyHospitalVC alloc]init];
        hosVC.id = model.id;
        [self.navigationController pushViewController:hosVC animated:YES];
        
    }else if ([_type isEqualToString:@"1"]){
        
        HYDNearbyDrugStoreVC *stoVC = [[HYDNearbyDrugStoreVC alloc]init];
        stoVC.id = model.id;
        [self.navigationController pushViewController:stoVC animated:YES];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.view.bounds.size.height * .14;
}


@end
