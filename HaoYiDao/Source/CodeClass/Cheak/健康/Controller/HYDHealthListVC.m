//
//  HYDHealthListVC.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/25.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "HYDHealthListVC.h"
#import "HYDHealthCommon.h"
#import "HYDHTMLWebVC.h"
#import "HYDHealthBookMenuVC.h"

@interface HYDHealthListVC ()<UITableViewDataSource,UITableViewDelegate>
{
    int rows;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HYDHealthListVC

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
    [_tableView registerClass:[HYDHealthListCell class]
       forCellReuseIdentifier:@"cell"];
 
    rows = 10;
}

- (void) p_requestData {
    
    NSString *method = [NSString stringWithFormat:@"/list?id=%@&rows=%d",_id,rows];
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
    
    NSArray *array = [NSArray array];
    if (_tag == 4) {
        array = [(NSDictionary *)data valueForKey:@"list"];
    }else {
        array = [(NSDictionary *)data valueForKey:@"tngou"];
    }
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
    
    HYDHealthListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HYDHealthModel *model = _dataArray[indexPath.row];
    
    if (_tag == 4) {
        cell.titleLabel.text = model.name;
        cell.introductionLabel.text = model.summary;
    }else {
        cell.titleLabel.text = model.title;
        cell.introductionLabel.text = model.des;
    }
    NSString *img = [NSString stringWithFormat:@"%@%@_100x100",HYDHEALTH_IMG,model.img];
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:img]
                      placeholderImage:[UIImage imageNamed:@"logo_button"]];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80 * HEIGHTSCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHealthModel *model = _dataArray[indexPath.row];
    NSString *method = [NSString stringWithFormat:@"/show?id=%@",model.Id];
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
            
        default:
            break;
    }
    
    if (_tag == 4) {
        HYDHealthBookMenuVC *vc = [[HYDHealthBookMenuVC alloc]init];
        vc.Id = model.Id;
        [self.navigationController pushViewController:vc
                                             animated:YES];
        
    }else {
        
        HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
        vc.Load_Type = LoadTypeTiangou;
        vc.urlString = method;
        [self.navigationController pushViewController:vc
                                             animated:YES];
        
    }
}

- (void) p_showData:(id)data {
    
    HYDHealthModel *model = [[HYDHealthModel alloc]init];
    [model setValuesForKeysWithDictionary:(NSDictionary *)data];
    HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
    vc.title = model.title;
    vc.Load_Type = LoadTypeTiangou;
    vc.htmlString = model.message;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

@end
