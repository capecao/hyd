//
//  HYDHomeClassifyVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/2.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeClassifyVC.h"
#import "HYDHomeClassifyView.h"
#import "HYDHomePageCommon.h"
#import "HYDHomeClassifyDiseaseVC.h"

@interface HYDHomeClassifyVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSIndexPath *indexPath0;
}
@property (nonatomic,strong) HYDHomeClassifyView *itemView;
@property (nonatomic,strong) NSMutableArray *dataArray_0;
@property (nonatomic,strong) NSMutableArray *dataArray_1;

@end

@implementation HYDHomeClassifyVC

- (void)loadView {
    [super loadView];
    
    self.itemView = [[HYDHomeClassifyView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _itemView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"URL = %@",_URL);
    
    indexPath0 = [NSIndexPath indexPathForRow:0 inSection:0];
    self.dataArray_0 = [NSMutableArray array];
        
    [self p_setupViewFeatures];
    
    [self p_setupRequestedData];
}


- (void) p_setupViewFeatures {
    
    [_itemView.tableView0 registerClass:[HYDHomeClassifyCell class]
                 forCellReuseIdentifier:@"cell0"];
    _itemView.tableView0.dataSource = self;
    _itemView.tableView0.delegate = self;
    
    [_itemView.tableView1 registerClass:[HYDHomeClassifyCell class]
                 forCellReuseIdentifier:@"cell1"];
    _itemView.tableView1.dataSource = self;
    _itemView.tableView1.delegate = self;
    
}

- (void) p_setupRequestedData {
    
    __block NSDictionary *dictionary = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager POST:_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                         options:NSJSONReadingMutableContainers |
                          NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"keys of dictionary:%@",[dictionary allKeys]);

            if ([dictionary allKeys].count)
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSArray *array = [(NSDictionary *)[dictionary valueForKey:@"data"] valueForKey:@"classList"];
                    for (NSDictionary *dic in array) {
                        
                        HYDHomeClassifyModel *model = [[HYDHomeClassifyModel alloc]init];
                        [model setValuesForKeysWithDictionary:dic];
                        [_dataArray_0 addObject:model];
                    }
                    
                    [_itemView.tableView0 reloadData];
                    
                    self.dataArray_1 = [NSMutableArray array];
                    HYDHomeClassifyModel *model = (HYDHomeClassifyModel *)_dataArray_0[0];
                    for (NSDictionary *dic in (NSArray *)model.deseaseList) {
                        HYDHomeClassifyModel *m = [[HYDHomeClassifyModel alloc]init];
                        [m setValuesForKeysWithDictionary:dic];
                        [_dataArray_1 addObject:m];
                    }
                    [_itemView.tableView1 reloadData];
                    
                });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"request Error: %@",error);
        }];
        
    });
    
}

#pragma mark UITableViewDataSource,UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:_itemView.tableView0]) {
        return _dataArray_0.count;
    }
    return _dataArray_1.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_itemView.tableView0]) {
        
        HYDHomeClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"
                                                                    forIndexPath:indexPath];
        
        HYDHomeClassifyModel *model = (HYDHomeClassifyModel *)_dataArray_0[indexPath.row];
        
        if ([indexPath0 isEqual:indexPath]) {
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.titleLab.textColor = HYD_themeColor;
            cell.titleLab.font = HYD_font_MEDIUM(14.f);
        }else {
            
            cell.backgroundColor = [UIColor colorWithWhite:.8 alpha:.1];
            cell.titleLab.textColor = [UIColor colorwithHexString:@"#414141"];
            cell.titleLab.font = HYD_font(14.f);
        }
        cell.titleLab.text = model.className;
        
        return cell;

    }
    
    HYDHomeClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"
                                                                  forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    HYDHomeClassifyModel *model = (HYDHomeClassifyModel *)_dataArray_1[indexPath.row];
    cell.titleLab.text = model.deseaseName;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if ([tableView isEqual:_itemView.tableView0]) {
        
        return 54 * HEIGHTSCALE;
    }
    
    return 44 * HEIGHTSCALE;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_itemView.tableView0]) {
        
        indexPath0 = indexPath;
        [_itemView.tableView0 reloadData];

        if (_dataArray_1) {
            [_dataArray_1 removeAllObjects];
        }
        self.dataArray_1 = [NSMutableArray array];
        HYDHomeClassifyModel *model = (HYDHomeClassifyModel *)_dataArray_0[indexPath.row];
        for (NSDictionary *dic in (NSArray *)model.deseaseList) {
            HYDHomeClassifyModel *m = [[HYDHomeClassifyModel alloc]init];
            [m setValuesForKeysWithDictionary:dic];
            [_dataArray_1 addObject:m];
        }
        [_itemView.tableView1 reloadData];
    }else {
        
        HYDHomeClassifyDiseaseVC *VC = [[HYDHomeClassifyDiseaseVC alloc]init];
        HYDHomeClassifyModel *model = (HYDHomeClassifyModel *)_dataArray_1[indexPath.row];
        VC.deseaseId = model.deseaseId;
        VC.title = model.deseaseName;
        [self.navigationController pushViewController:VC animated:YES];
        
    }
}


@end
