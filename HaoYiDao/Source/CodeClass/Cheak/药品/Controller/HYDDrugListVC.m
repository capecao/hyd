//
//  HYDDrugListVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDDrugListVC.h"
#import "HYDDrugList_1Model.h"
#import "HYDDrugDetailListVC.h"
#import "HYDDrugCommon.h"

@interface HYDDrugListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *leftTbale;
@property (nonatomic,strong) UITableView *rightTbale;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *contentView;


@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *nextDateArray;

@property (strong, nonatomic) PGCategoryView *categoryView;

@end

@implementation HYDDrugListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"药品大全";
    
    self.dataArray = [NSMutableArray array];
    
    [self p_setupView];
    [self p_requestData];
}


- (void)p_requestData {
    
    self.dataArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    __block NSDictionary *dictionary = [NSDictionary new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:UrldrugFirst parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"classifyList"]];
        
        for (NSDictionary *dic in array) {
            
            HYDDrugList_1Model *model = [[HYDDrugList_1Model alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [weakSelf.leftTbale reloadData];
        
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
        HYDDrugList_1Model *model = _dataArray[indexPath.row];
        cell.textLabel.font = HYD_font(14.f);
        cell.textLabel.text = model.className;
        
        return cell;
        
    }else{
        
        static NSString *CellIdentifier2 = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        }
        cell.textLabel.font = HYD_font(13.f);
        cell.textLabel.text = _nextDateArray[indexPath.row][@"className"];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _leftTbale) {
        
        HYDDrugList_1Model *model = _dataArray[indexPath.row];
        self.nextDateArray = [NSMutableArray arrayWithArray:model.twoType];
        [self.rightTbale reloadData];
        self.title = model.className;
        [_categoryView show];
        
    }else{
        
        HYDDrugDetailListVC *detailVC = [[HYDDrugDetailListVC alloc]init];
        detailVC.tempId = _nextDateArray[indexPath.row][@"classId"];
        [self.navigationController pushViewController:detailVC animated:YES];

    }
    
}

@end
