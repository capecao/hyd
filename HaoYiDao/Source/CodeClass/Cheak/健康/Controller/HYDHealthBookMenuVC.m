//
//  HYDHealthBookMenuVC.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/25.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "HYDHealthBookMenuVC.h"
#import "HYDHealthCommon.h"
#import "HYDHTMLWebVC.h"

@interface HYDHealthBookMenuVC ()

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HYDHealthBookMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[HYDHealthClassifyCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self p_requestData];
}

- (void)p_requestData {
    
    self.dataArray = [NSMutableArray array];
    NSString *method = [NSString stringWithFormat:@"book/show?id=%@",_Id];
    [[HYDHealthNetRequest shareInstance] netRequestWithParameter:nil
                                                          Method:method
                                                           Block:^(id result) {
                                                               [self p_analysisData:result];
                                                           } Error:^(id error) {
                                                               
                                                           }];
}

- (void) p_analysisData:(id)data {
    NSArray *array = [(NSDictionary *)data valueForKey:@"list"];
    
    for (NSDictionary *d in array) {
        HYDHealthModel *model = [[HYDHealthModel alloc]init];
        [model setValuesForKeysWithDictionary:d];
        [_dataArray addObject:model];
    }
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHealthClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HYDHealthModel *model = _dataArray[indexPath.row];
    cell.titleLab.text = model.title;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHealthModel *model = _dataArray[indexPath.row];
    HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
    vc.title = model.title;
    vc.Load_Type = LoadTypeString;
    vc.htmlString = model.message;
    [self.navigationController pushViewController:vc
                                         animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40 * HEIGHTSCALE;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
