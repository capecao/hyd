//
//  HYDHotSpotVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNewsHotSpotVC.h"
#import "HYdNewsCommon.h"
#import "HYDNewsListCell.h"
#import "HYDNewsListModel.h"
#import "HYDNetWorkinf_Helper.h"

@interface HYDNewsHotSpotVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int _start;
    int _rows;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSString *httpUrl;

@end

@implementation HYDNewsHotSpotVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self p_setupTableView];
    _start = 0;
    _rows = 15;
    self.httpUrl = [NSString stringWithFormat:HYD_NEWS_FOCUSE,_start,_rows];
    self.dataArray = [NSMutableArray array];
    [self p_requestNewsData:_httpUrl];
    [self p_refreshNews];
}

- (void) p_setupTableView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0,
                                 0,
                                 self.view.bounds.size.width,
                                 self.view.bounds.size.height - 113)
                                                 style:(UITableViewStylePlain)];
    
    [_tableView registerClass:[HYDNewsListCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/* 请求数据 */
- (void) p_requestNewsData:(NSString *)urlString {
    
    __block NSDictionary *dictionary = [NSDictionary new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:_httpUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers |
                      NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"channelinfoList"]];
        
        if (array.count > 0) {
            
            for (NSDictionary *dic in array) {
                
                HYDNewsListModel *model = [[HYDNewsListModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArray addObject:model];
            }
            
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];

        }else {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/* 刷新 */
- (void) p_refreshNews {
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _start += _rows;
        _rows += 15;
        NSString *tepmStr = [NSString stringWithFormat:@"start=%ld",(long)_start];
        NSString *urlString = [_httpUrl stringByReplacingOccurrencesOfString:@"start=0" withString:tepmStr];
        [self p_requestNewsData:urlString];
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSString *tepmStr = [NSString stringWithFormat:@"start=%ld",(long)_start];
        NSString *urlString = [_httpUrl stringByReplacingOccurrencesOfString:@"start=0" withString:tepmStr];
        
        [self p_requestNewsData:urlString];
        
    }];

    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HYDNewsListModel *model = _dataArray[indexPath.row];
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    cell.titleLabel.text = model.dataTitle;
    cell.introductionLabel.text = model.content;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHTMLWebVC *webVC = [[HYDHTMLWebVC alloc]init];
    HYDNewsListModel *model = _dataArray[indexPath.row];
    webVC.urlString = [itemClickedUrl stringByAppendingString:model.dataId];
    webVC.title = model.dataTitle;
    webVC.Load_Type = LoadTypeNormalUrl;
    HYDNavigationController *nc = [[HYDNavigationController alloc]initWithRootViewController:webVC];
    [nc.logoImageView removeFromSuperview];
    
    [self presentViewController:nc
                       animated:YES
                     completion:nil];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80 * HEIGHTSCALE;
}


@end
