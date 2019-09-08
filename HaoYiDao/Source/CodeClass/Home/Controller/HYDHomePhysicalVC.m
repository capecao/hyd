//
//  HYDHomePhysicalVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomePhysicalVC.h"
#import "HYDHomePageCommon.h"
#import "HYDHomePhysicalCell.h"
#import "HYDHomePhysicalModel.h"

@interface HYDHomePhysicalVC () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HYDHomePhysicalVC

- (void)loadView {
    [super loadView];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:_tableView];
    
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"口袋体检";
    [self p_setupTableView];
    [self p_requestData];
    
}

- (void) p_setupTableView {
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_tableView registerClass:[HYDHomePhysicalCell class] forCellReuseIdentifier:@"cell"];
     
}

- (void) p_requestData {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    __block NSDictionary *dictionary = [NSDictionary new];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:HOME_PHYSICAL_LIST parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"medicalToolList"]];
        
        for (NSDictionary *dic in array) {
            
            HYDHomePhysicalModel *model = [[HYDHomePhysicalModel alloc]init];
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
    
    HYDHomePhysicalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    HYDHomePhysicalModel *model = _dataArray[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.quizPic]
                    placeholderImage:[UIImage imageNamed:@"logo_button"]];
    cell.titLab.text = model.quizTitle;
    cell.infoLab.text = model.quizIntro;
    cell.numLab.text = [NSString stringWithFormat:@"%.1f万人已测试",[model.quizNum floatValue] / 10000];

    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100 * HEIGHTSCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
    HYDHomePhysicalModel *model = _dataArray[indexPath.row];
    vc.urlString = [NSString stringWithFormat:HOME_PHTSICAL_TEST,model.quizId];
    vc.Load_Type = LoadTypeNormalUrl;
    vc.title = model.quizTitle;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
