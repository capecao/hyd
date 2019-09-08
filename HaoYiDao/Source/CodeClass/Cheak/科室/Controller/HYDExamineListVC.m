//
//  HYDExamineListVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDExamineListVC.h"
#import "HYDDrugCommon.h"
#import "HYDExamineListModel.h"

@interface HYDExamineListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *leftTbale;
@property (nonatomic,strong) UITableView *rightTbale;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *contentView;


@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *nextDateArray;

@property (strong, nonatomic) PGCategoryView *categoryView;

@end

@implementation HYDExamineListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"检查项目";
    
    [self p_setupView];
    
    self.dataArray = [NSMutableArray new];
    [self p_requestData:_dataArray :examinListUrl_1 :@"firstList"];
}


- (void)p_requestData:(NSMutableArray *)dataArray :(NSString *)httpUrl :(NSString *)key {
    
    __weak typeof(self) weakSelf = self;
    __block NSDictionary *dictionary = [NSDictionary new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:httpUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[key]];
        
        for (NSDictionary *dic in array) {
            
            HYDExamineListModel *model = [[HYDExamineListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [dataArray addObject:model];
        }
        if ([key isEqualToString:@"firstList"])
            [weakSelf.leftTbale reloadData];
        else
            [weakSelf.rightTbale reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)p_setupView {
    
    self.contentView = [[UIView alloc] init];
    _contentView.frame = CGRectMake(self.view.bounds.size.width, 0,self.view.bounds.size.width, self.view.bounds.size.height);
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentView];
    
    [self.leftTbale registerClass:[UITableView class] forCellReuseIdentifier:@"left"];
    self.leftTbale = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:(UITableViewStylePlain)];
    _leftTbale.dataSource = self;
    _leftTbale.delegate = self;
    _leftTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _leftTbale.showsVerticalScrollIndicator = NO;
    _leftTbale.tableFooterView = [[UIView alloc] init];
    [self.view insertSubview:_leftTbale belowSubview:_contentView];
    
    self.rightTbale = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _contentView.bounds.size.width, _contentView.bounds.size.height) style:(UITableViewStylePlain)];
    _rightTbale.dataSource = self;
    _rightTbale.delegate = self;
    _rightTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _rightTbale.showsVerticalScrollIndicator = NO;
    _rightTbale.tableFooterView = [[UIView alloc] init];
    [_contentView addSubview:_rightTbale];
    
    CGRect frame = _contentView.frame;
    frame.origin.x -= 30;
    frame.size.width = 30;
    _categoryView = [PGCategoryView categoryRightView:_contentView];
    _categoryView.frame = frame;
    [self.view addSubview:_categoryView];
    
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _leftTbale) {
        return _dataArray.count;
        
    }else
        return _nextDateArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _leftTbale) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        HYDExamineListModel *model = _dataArray[indexPath.row];
        cell.textLabel.font = HYD_font(14.f);
        cell.textLabel.text = model.dataName;
        
        return cell;
        
    }else{
        
        static NSString *CellIdentifier2 = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        }
        cell.textLabel.font = HYD_font(13.f);
        HYDExamineListModel *model = _nextDateArray[indexPath.row];
        cell.textLabel.text = model.dataName;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _leftTbale) {
        
        HYDExamineListModel *model = _dataArray[indexPath.row];
        NSString *urlString = [examinListUrl_2 stringByAppendingString:model.dataId];
        self.nextDateArray = [NSMutableArray array];
        [self p_requestData:_nextDateArray :urlString :@"secondList"];
        self.title = model.dataName;
        [_categoryView show];
        
    }else{
        
        HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
        HYDExamineListModel *model = _nextDateArray[indexPath.row];
        vc.urlString = [NSString stringWithFormat:CHECKINFO_URL,model.dataId];
        vc.Load_Type = LoadTypeNormalUrl;
        vc.title = model.dataName;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

@end
