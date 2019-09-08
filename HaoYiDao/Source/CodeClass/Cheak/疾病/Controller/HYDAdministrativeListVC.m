//
//  HYDAdministrativeListVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/31.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDAdministrativeListVC.h"
#import "HYDAdministrativeCell.h"
#import "HYDAdministrativeModel.h"
#import "HYDDiseaseCommon.h"

@interface HYDAdministrativeListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HYDAdministrativeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-BG"]];
    [self p_setupView];
    [self p_requestData];
}


- (void)p_setupView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.centerX,
                                                                  64,
                                                                  self.view.centerX,
                                                                  self.view.bounds.size.height - 100)
                                                 style:(UITableViewStylePlain)];
    
    [_tableView registerClass:[HYDAdministrativeCell class] forCellReuseIdentifier:@"cell"];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


- (void)p_requestData {
    
    self.dataArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    __block NSDictionary *dictionary = [NSDictionary new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:HYDAdministrativeListUrl parameters:nil
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers |
                      NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"commonDiseaseList"]];
        
        for (NSDictionary *dic in array) {
            
            HYDAdministrativeModel *model = [[HYDAdministrativeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        
        [weakSelf.tableView reloadData];
        
        HYDAdministrativeModel *model = [_dataArray firstObject];
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        [settings removeObjectForKey:HYDDISEASELIST_STANDAR0];
        [settings setObject:model.twoType forKey:HYDDISEASELIST_STANDAR0];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDAdministrativeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HYDAdministrativeModel *model = _dataArray[indexPath.row];
    cell.nameLabel.text = model.dataName;
    cell.titImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",model.dataName]];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDAdministrativeModel *model = _dataArray[indexPath.row];
    NSDictionary *infoDic = @{@"data":model.twoType,@"title":model.dataName};
    [self p_setNotice:infoDic];
    [self.sideMenuViewController hideMenuViewController];
}

- (void) p_setNotice:(NSDictionary *)infoDic {
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:HYDADMINISTRATIVENOTIFICATION
                                                            object:nil userInfo:infoDic];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

@end


