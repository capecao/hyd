//
//  HYDSearchVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/9.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSearchVC.h"
#import "HYDSearchBaseCell.h"
#import "HYDSearchCommon.h"
#import "HYDSearchResultVC.h"


@interface HYDSearchVC ()<UISearchBarDelegate,UITextFieldDelegate,
UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITextField *searchTF;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *tempArray;
@property (nonatomic,strong) UITableView *tableView;

@end

#define SEARCHBARTEXTCHANGED @"SEARCHBARTEXTCHANGED"
@implementation HYDSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self p_setupViewFeatures];
    
//    //获取通知中心单例对象
//    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(notice:) name:SEARCHBARTEXTCHANGED object:nil];
//    
}

-(void)notice:(NSNotification *)sender{
    
    UISearchBar * searchBar = (UISearchBar *)sender.object;
    NSString *toBeString = searchBar.text;
    NSLog(@"toBeString = %@",toBeString);
}


- (void) p_setupViewFeatures {
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300 * WIDTHTSCALE, 36 * HEIGHTSCALE)];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.layer.cornerRadius = titleView.frame.size.height * .5;
    titleView.layer.borderColor = [UIColor greenColor].CGColor;
    titleView.layer.borderWidth = 1;
    titleView.layer.masksToBounds = YES;
#pragma mark 设置任意边角的圆角
    /*
     UIBezierPath *maskPath =
     [UIBezierPath bezierPathWithRoundedRect:searchTF.bounds
     byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
     cornerRadii:CGSizeMake(searchTF.bounds.size.height * .5,
     searchTF.bounds.size.height * .5)];
     CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
     maskLayer.frame = searchTF.bounds;
     maskLayer.path = maskPath.CGPath;
     searchTF.layer.mask = maskLayer;
     */

    
    self.searchTF = [[UITextField alloc]init];
    _searchTF.frame = CGRectMake(18 * HEIGHTSCALE, 0,
                                 titleView.frame.size.width - 54 * HEIGHTSCALE,
                                 36 * HEIGHTSCALE);
    
    _searchTF.returnKeyType = UIReturnKeySearch;
    _searchTF.textAlignment = NSTextAlignmentCenter;
    _searchTF.delegate = self;
    _searchTF.backgroundColor = [UIColor whiteColor];
    _searchTF.placeholder = @"疾病，文章，药物，症状";
    [titleView addSubview:_searchTF];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(searchBtAct:)];
    
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
    self.tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0, 0, self.view.frame.size.width,
                                 self.view.frame.size.height - 64)
                                                 style:(UITableViewStylePlain)];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate  = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HYDSearchBaseCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void) searchBtAct:(UIButton *)sender {
    if (_searchTF.text.length) {
        [self p_requestSearchResultData:_searchTF.text];
    }
}


/**
 联系词

 @param key 索引搜索
 */
- (void) p_requestSearchRelatedWords:(NSString *)key {
    
    __block NSDictionary *dictionary = [NSDictionary new];
    NSString *urlString = [NSString stringWithFormat:HYDSEARCH_LENOVO_URLSTRING,key];
    self.tempArray = [NSMutableArray array];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
        [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSDictionary *dic = [dictionary valueForKey:@"data"];
            if (dic){
                NSArray *array = [dic valueForKey:@"lenovoWordList"];
                for (NSDictionary *dic in array) {
                    HYDSearchBaseModel *model = [[HYDSearchBaseModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [_tempArray addObject:model];
                }
                
                [_tableView reloadData];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
}

#pragma mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    NSString *key = [textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self p_requestSearchResultData:key];
    textField.text = @"";
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString *key = [textField.text stringByReplacingCharactersInRange:range
                                                            withString:string];
    key = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 根据输入的索引搜索
    [self p_requestSearchRelatedWords:key];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    textField.textAlignment = NSTextAlignmentLeft;
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    textField.textAlignment = NSTextAlignmentCenter;

}

- (void) p_requestSearchResultData:(NSString *)key {
    
    __block NSDictionary *dictionary = [NSDictionary new];
    NSString *urlString = [NSString stringWithFormat:HYDSEARCH_REQUEST_URLSTRING,key];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSDictionary *dict = [dictionary valueForKey:@"data"];
            NSArray *array = [dict valueForKey:@"searchResultList"];
            if (array.count > 0)
                dispatch_async(dispatch_get_main_queue(), ^{
                    HYDSearchResultVC *vc = [[HYDSearchResultVC alloc]init];
                    vc.dataArray = array;
                    vc.title = [key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [self.navigationController pushViewController:vc animated:YES];
                });
            else
                [ProgressHUD showError:@"暂无数据..."];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    });    
}


#pragma mark UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tempArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDSearchBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HYDSearchBaseModel *model = _tempArray[indexPath.row];
    cell.titleLab.text = model.assoc_word;
    cell.removeBt.hidden = YES;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_tempArray.count > indexPath.row) {
        
        HYDSearchBaseModel *model = _tempArray[indexPath.row];
        NSString *key = [model.assoc_word
                         stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self p_requestSearchResultData:key ];
    }
}

// 关键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}



@end
