//
//  HYDUserCollectionVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/19.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDUserCollectionVC.h"
#import "HYDUserCenterCell.h"

@interface HYDUserCollectionVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation HYDUserCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self p_getData];
    [self p_setupTableView];
    
}

- (void) p_getData {
    
    //去重
    NSArray *array = [CollectionModel MR_findAll];
    for (int i = 0; i < array.count; i ++) {
        CollectionModel *m = array[i];
        for (int j = 0; j < array.count; j ++) {
            CollectionModel *model = array[j];
            if (i != j) {
                if ([m.title isEqualToString:model.title]) {
                    [model MR_deleteEntity];
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                }
            }
        }
    }
    self.dataArray = [NSMutableArray arrayWithArray:[CollectionModel MR_findAll]];
}

- (void) p_setupTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0, 0,
                                 self.view.bounds.size.width,
                                 self.view.bounds.size.height - 64)
                                                 style:(UITableViewStylePlain)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HYDUserCenterCell class]
       forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    
    
}

#pragma mark UITableViewDataSource,UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDUserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CollectionModel *model = _dataArray[indexPath.row];
    cell.titLab.text = model.title;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40 * HEIGHTSCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHTMLWebVC *webVC = [[HYDHTMLWebVC alloc]init];
    CollectionModel *model = _dataArray[indexPath.row];
    webVC.urlString = model.urlString;
    webVC.title = model.title;
    webVC.Load_Type = model.loadType;
    webVC.htmlString = model.htmlString;
    [self.navigationController pushViewController:webVC
                                         animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        CollectionModel *model = _dataArray[indexPath.row];
        [model MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [self p_getData];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
