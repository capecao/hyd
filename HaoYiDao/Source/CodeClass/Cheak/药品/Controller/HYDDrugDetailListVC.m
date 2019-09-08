//
//  HYDDrugDetailListVC.m
//  HaoYiDao
//
//  Created by capecao on 16/5/28.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDDrugDetailListVC.h"
#import "HYDDrugList_2Cell.h"
#import "HYDDrugList_2Model.h"
#import "HYDDrugCommon.h"

@interface HYDDrugDetailListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HYDDrugDetailListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.tableView registerClass:[HYDDrugList_2Cell class] forCellReuseIdentifier:@"cell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [self p_requestData];
}

- (void) p_requestData {
    
    self.dataArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    __block NSDictionary *dictionary = [NSDictionary new];
    NSString *urlString = [urlDrugListThird stringByAppendingString:self.tempId];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"drugList"]];
        
        for (NSDictionary *dic in array) {
            
            HYDDrugList_2Model *model = [[HYDDrugList_2Model alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDDrugList_2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    HYDDrugList_2Model *model = _dataArray[indexPath.row];
    
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.drugPic]];
    
    if ([model.OTC isEqualToString:@"1"]) {
        
        [cell.counterImageView sd_setImageWithURL:[NSURL URLWithString:otcStr]];
        
    }else if ([model.OTC isEqualToString:@"0"]) {
        
        [cell.typeImageView sd_setImageWithURL:[NSURL URLWithString:unotcStr]];
    }
    
    if ([model.xiyao isEqualToString:@"1"]) {
        
        [cell.typeImageView sd_setImageWithURL:[NSURL URLWithString:xiyaoStr] placeholderImage:[UIImage imageNamed:@"logo_button"]];
        
    }else if([model.xiyao isEqualToString:@"0"])
    {
        
        [cell.typeImageView sd_setImageWithURL:[NSURL URLWithString:zhongyaoStr]];
    }
    
    cell.titleLabel.text = model.drugName;
    cell.infolabel.text = model.indication;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
    HYDDrugList_2Model *model = _dataArray[indexPath.row];
    vc.urlString = [NSString stringWithFormat:HYD_DRUGLIST_DRUG,model.drugId];
    vc.Load_Type = LoadTypeNormalUrl;
    vc.title = model.drugName;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
