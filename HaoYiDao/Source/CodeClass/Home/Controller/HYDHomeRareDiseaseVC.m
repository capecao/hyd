//
//  HYDHomeRareDiseaseVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeRareDiseaseVC.h"
#import "HYDHomePageCommon.h"
#import "HYDHomeRareDiseaseCell.h"
#import "HYDHomeRareDiseaseModel.h"
#import "HYDHomeClassifyDiseaseVC.h"

@interface HYDHomeRareDiseaseVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSIndexPath *indexPath0;
}
@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *rightTableView;
@property (nonatomic,strong) NSMutableArray *dataArray_0;
@property (nonatomic,strong) NSMutableArray *dataArray_1;

@end

@implementation HYDHomeRareDiseaseVC

- (void)loadView {
    [super loadView];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"大病罕见病";
    indexPath0 = [NSIndexPath indexPathForRow:0 inSection:0];
    self.dataArray_0 = [NSMutableArray array];
    
    [self p_setupViewFeatures];
    
    [self p_setupRequestedData];
}


- (void) p_setupViewFeatures {
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.leftTableView = [[UITableView alloc]initWithFrame:
                          CGRectMake(0, 0, self.view.frame.size.width * .45,
                                     self.view.frame.size.height)
                                                     style:(UITableViewStylePlain)];
    [self.view addSubview:_leftTableView];
    
    self.rightTableView = [[UITableView alloc]initWithFrame:
                           CGRectMake(CGRectGetMaxX(_leftTableView.frame), 0,
                                      self.view.frame.size.width * .55,
                                      self.view.frame.size.height)
                                                      style:(UITableViewStylePlain)];
    [self.view addSubview:_rightTableView];
    
    [_leftTableView registerClass:[HYDHomeRareDiseaseCell class]
                 forCellReuseIdentifier:@"cell0"];
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.backgroundColor = [UIColor whiteColor];
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_rightTableView registerClass:[HYDHomeClassifyCell class]
           forCellReuseIdentifier:@"cell1"];
    _rightTableView.dataSource = self;
    _rightTableView.delegate = self;
    _rightTableView.backgroundColor = [UIColor whiteColor];
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void) p_setupRequestedData {
    
    self.dataArray_0 = [NSMutableArray array];
    self.dataArray_1 = [NSMutableArray array];
    
    __block NSDictionary *dictionary = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:HOME_RAREDISEASR_LIST parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"rareDiseaseList"]];
        
        for (NSDictionary *dic in array) {
            
            HYDHomeRareDiseaseModel *model = [[HYDHomeRareDiseaseModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray_0 addObject:model];
            
        }
        
        HYDHomeRareDiseaseModel *model = (HYDHomeRareDiseaseModel *)_dataArray_0[0];
        for (NSDictionary *dic in (NSArray *)model.twoType) {
            HYDHomeRareDiseaseModel *m = [[HYDHomeRareDiseaseModel alloc]init];
            [m setValuesForKeysWithDictionary:dic];
            [_dataArray_1 addObject:m];
        }
        
        [_leftTableView reloadData];
        [_rightTableView reloadData];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}

#pragma mark UITableViewDataSource,UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:_leftTableView]) {
        return _dataArray_0.count;
    }
    return _dataArray_1.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_leftTableView]) {
        
        HYDHomeRareDiseaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"
                                                                    forIndexPath:indexPath];
        
        HYDHomeRareDiseaseModel *model = (HYDHomeRareDiseaseModel *)_dataArray_0[indexPath.row];
        cell.titLab.text = model.dataName;
        
        if ([indexPath0 isEqual:indexPath]) {
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.titLab.textColor = [UIColor colorwithHexString:@"#36aeed"];
            cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",model.dataName]];

        }else {
            
            cell.backgroundColor = [UIColor colorWithWhite:.8 alpha:.1];
            cell.titLab.textColor = [UIColor colorwithHexString:@"#414141"];
            cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",model.dataName]];
        }
        
        return cell;
        
    }
    
    HYDHomeClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"
                                                                forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    HYDHomeRareDiseaseModel *model = (HYDHomeRareDiseaseModel *)_dataArray_1[indexPath.row];
    cell.titleLab.text = model.dataName;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_leftTableView]) {
        
        return 50 * HEIGHTSCALE;
    }
    
    return 40 * HEIGHTSCALE;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_leftTableView]) {
        
        indexPath0 = indexPath;
        [_leftTableView reloadData];
        
        if (_dataArray_1) {
            [_dataArray_1 removeAllObjects];
        }
        self.dataArray_1 = [NSMutableArray array];
        HYDHomeRareDiseaseModel *model = (HYDHomeRareDiseaseModel *)_dataArray_0[indexPath.row];
        for (NSDictionary *dic in (NSArray *)model.twoType) {
            HYDHomeRareDiseaseModel *m = [[HYDHomeRareDiseaseModel alloc]init];
            [m setValuesForKeysWithDictionary:dic];
            [_dataArray_1 addObject:m];
        }
        
        [_rightTableView reloadData];
        
    }else {
        
        HYDHomeClassifyDiseaseVC *VC = [[HYDHomeClassifyDiseaseVC alloc]init];
        HYDHomeRareDiseaseModel *model = (HYDHomeRareDiseaseModel *)_dataArray_1[indexPath.row];
        VC.deseaseId = model.dataId;
        VC.title = model.dataName;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

@end
