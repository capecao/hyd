//
//  HYDHomeClassifyTipsVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/13.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeClassifyTipsVC.h"
#import "HYDHomeClassifyTipsCell.h"
#import "HYDHomePageCommon.h"

@interface HYDHomeClassifyTipsVC ()

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HYDHomeClassifyTipsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray array];
        
    [self p_setupTableView];
    
    NSString *urlString = [NSString stringWithFormat:HYD_LIFT_TIPS,10,0];
    [self p_requestData:urlString];
    
    [self p_refreshData];
}

- (void) p_setupTableView {
    
    [self.tableView registerClass:[HYDHomeClassifyTipsCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void) p_requestData:(NSString *)urlString {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dictionary = [NSDictionary dictionary];
            dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            
            if ([dictionary allKeys].count)
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
                    NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"articleList"]];
                    
                    for (NSDictionary *dic in array) {
                        
                        HYDHomeClassifyModel *model = [[HYDHomeClassifyModel alloc]init];
                        [model setValuesForKeysWithDictionary:dic];
                        [_dataArray addObject:model];
                    }
                    [self.tableView.mj_footer endRefreshing];
                    [self.tableView reloadData];
                });
            
            else {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];

            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
    });
}

- (void) p_refreshData {
    
    __block int rows = 10;
    __block int start = 0;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        start = rows;
        rows += 10;
        NSString *urlString = [NSString stringWithFormat:HYD_LIFT_TIPS,rows,start];
        [self p_requestData:urlString];
        
    }];
    
}

#pragma mark TableView Data&delegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHomeClassifyTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HYDHomeClassifyModel *model = _dataArray[indexPath.row];
    cell.titLab.text = model.title;
    cell.timeLab.text = model.time;
    NSArray *marks = model.articleTags;
    NSString *message = @"";
    if (marks.count)
        for (NSDictionary *dic in marks) {
            NSString *str = [dic valueForKey:@"name"];
            message = [message stringByAppendingString:[NSString stringWithFormat:@"%@ ",str]];
        }
    
    cell.markLab.text = message;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"logo_button"]];
    
    return cell;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90 * HEIGHTSCALE;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHomeClassifyModel *model = _dataArray[indexPath.row];
    HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
    if (!model.articleUrl)
        vc.urlString = [NSString stringWithFormat:HYD_LIFE_TIPS_INFO,model.articleId];
    vc.urlString = model.articleUrl;
    vc.Load_Type = LoadTypeNormalUrl;
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
