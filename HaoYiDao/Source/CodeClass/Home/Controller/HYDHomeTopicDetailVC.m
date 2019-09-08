//
//  HYDTopicDetailVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/27.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeTopicDetailVC.h"
#import "HYDHomePageCommon.h"
#import "HYDHomeTopicDetailCell.h"
#import "HYDHomeTopicDetailModel.h"

@interface HYDHomeTopicDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _page;
}
@property (nonatomic,strong) NSString *urlStr;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIImageView *headImageView;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HYDHomeTopicDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                                  [UIScreen mainScreen].bounds.size.height - 64)
                                                 style:(UITableViewStylePlain)];
    
    [self.tableView registerClass:[HYDHomeTopicDetailCell class] forCellReuseIdentifier:@"cell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    NSString *str2 = [topicDetiallUrl stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)_model.id]];
    NSString *str3 = [str2 stringByAppendingString:@"&vc=3.7.1&vs=8.3"];
    self.urlStr = str3;

    _page = 2;
    
    [self p_requestData];
    
}

- (void)p_requestData {
    
    self.dataArray = [NSMutableArray array];
    __block NSDictionary *dictionary = [NSDictionary new];
    __weak typeof(self) weakself = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:_urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers |
                      NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"items"]];
        
        for (NSDictionary *dic in array) {
            
            HYDHomeTopicDetailModel *model = [[HYDHomeTopicDetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [weakself.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHomeTopicDetailModel *model = (HYDHomeTopicDetailModel *)_dataArray[indexPath.row];
    
    HYDHomeTopicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                                   forIndexPath:indexPath];
    
    cell.titleLabel.text = model.title;
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]
                           placeholderImage:[UIImage imageNamed:@"logo_button"]];
    
    return cell;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.view.bounds.size.height * .15;
}


- (void)layoutSublayersOfLayer:(CALayer *)layer {
    
    _headImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 160);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHTMLWebVC *webVC = [[HYDHTMLWebVC alloc]init];
    HYDHomeTopicDetailModel *model = _dataArray[indexPath.row];
    webVC.Load_Type = LoadTypeDingxiangyuan;
    webVC.title = model.title;
    webVC.urlString = [NSString stringWithFormat:TOPICDETIALINFO_URL,model.id];
    [self.navigationController pushViewController:webVC animated:YES];
}




@end
