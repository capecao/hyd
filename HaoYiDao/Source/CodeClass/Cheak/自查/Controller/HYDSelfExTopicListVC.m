//
//  HYDSelfExTopicListVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/30.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSelfExTopicListVC.h"
#import "HYDSelfExTopicListModel.h"
#import "HYDSelfExamationCommon.h"
#import "HYDSelfExDetailListVC.h"

@interface HYDSelfExTopicListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HYDSelfExTopicListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupView];
    [self p_requestData];
}

- (void) p_setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (void) p_requestData {
    
    self.dataArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    __block NSDictionary *dictionary = [NSDictionary new];
    
    NSString *s = [NSString stringWithFormat:SelfExamationTopicListUrl,_gender,_bodyKey];
    NSString *urlString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(CFAllocatorGetDefault(),
                                                                                    (CFStringRef)s,
                                                                                    nil,
                                                                                    nil,
                                                                                    kCFStringEncodingUTF8));
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers |
                      NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"checkSymptomList"]];
        
        for (NSDictionary *dic in array) {
            
            HYDSelfExTopicListModel *model = [[HYDSelfExTopicListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HYDSelfExTopicListModel *model = _dataArray[indexPath.row];
    cell.textLabel.font = HYD_font(14.f);
    cell.textLabel.text = model.symptomName;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYDSelfExDetailListVC *detailVC = [[HYDSelfExDetailListVC alloc] init];
    HYDSelfExTopicListModel *model = _dataArray[indexPath.row];
    detailVC.symptomId = model.symptomId;
    detailVC.gender = _gender;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


@end
