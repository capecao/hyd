//
//  HYDHealthClassifyVC.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/25.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "HYDHealthClassifyVC.h"
#import "HYDHealthCommon.h"
#import "HYDHealthListVC.h"

@interface HYDHealthClassifyVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HYDHealthClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self p_setupFeatures];
    [self p_requestData];
}

- (void) p_setupFeatures {
    
    CGRect frame = CGRectMake(0, 0,
                              self.view.bounds.size.width,
                              self.view.bounds.size.height - 64);
    self.tableView = [[UITableView alloc]initWithFrame:frame
                                                 style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HYDHealthClassifyCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void) p_requestData {
    
    NSString *method = @"/classify";
    switch (_tag) {
        case 1:
            method = [INFO stringByAppendingString:method];
            break;
        case 2:
            method = [KNOWN stringByAppendingString:method];
            break;
        case 3:
            method = [ASK stringByAppendingString:method];
            break;
        case 4:
            method = [BOOK stringByAppendingString:method];
            break;
            
        default:
            break;
    }
    
    self.dataArray = [NSMutableArray array];
    [[HYDHealthNetRequest shareInstance] netRequestWithParameter:nil
                                                          Method:method
                                                           Block:^(id result) {
                                                              [self p_analysisData:result];
                                                          } Error:^(id error) {
                                                              
                                                          }];
}

- (void) p_analysisData:(id)data {
    NSArray *array = [(NSDictionary *)data valueForKey:@"tngou"];
    for (NSDictionary *d in array) {
        HYDHealthModel *model = [[HYDHealthModel alloc]init];
        [model setValuesForKeysWithDictionary:d];
        [_dataArray addObject:model];
    }
    [_tableView reloadData];
}

#pragma mark tableView dataSource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHealthClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HYDHealthModel *model = _dataArray[indexPath.row];
    
    if (_tag == 4) {
        cell.titleLab.text = model.name;
    }else {
        cell.titleLab.text = model.title;
    }
    
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60 * HEIGHTSCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHealthListVC *vc = [[HYDHealthListVC alloc]init];
    HYDHealthModel *model = _dataArray[indexPath.row];
    vc.id = model.Id;
    vc.tag = _tag;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

@end
