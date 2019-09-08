//
//  HYDSelfExDetailListVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/30.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSelfExDetailListVC.h"
#import "HYDSelfExTopicListCell.h"
#import "HYDSelfExDetailListModel.h"
#import "HYDSelfExamationCommon.h"
#import "HYDSelfExDetailInfoVC.h"

@interface HYDSelfExDetailListVC ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat HeaderViewHeight;
    NSArray *headerTitles;
}
@property (nonatomic,strong) UITableView *tableView;

// 存放高可能患有疾病信息的模型数组
@property(nonatomic,strong) NSMutableArray *highListArray;

// 存放中等可能患有疾病信息的模型数组
@property (nonatomic,strong) NSMutableArray *middleListArray;

// 存放低可能患有疾病信息的模型数组
@property (nonatomic,strong) NSMutableArray *lowListArray;

// 存放模型的数组
@property (nonatomic,strong) NSArray *dataArray;

// 字典,key为
@property(nonatomic,strong)NSMutableDictionary *listDictionary;

@end

@implementation HYDSelfExDetailListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_requestData];
    [self p_setupView];
}

- (void) p_setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  self.view.bounds.size.width,
                                                                  self.view.bounds.size.height - 64)
                                                 style:(UITableViewStylePlain)];
    
    [_tableView registerClass:[HYDSelfExTopicListCell class] forCellReuseIdentifier:@"cell"];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void) p_requestData {
    
    HeaderViewHeight = 35;
    self.highListArray = [NSMutableArray new];
    self.middleListArray = [NSMutableArray new];
    self.lowListArray = [NSMutableArray new];
    self.dataArray = [NSMutableArray new];

    __weak typeof(self) weakSelf = self;
    __block NSDictionary *dictionary = [NSDictionary new];
    
    NSString *urlString = [NSString stringWithFormat:SelfExamationDetailListUrl,_symptomId,_gender];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers |
                      NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array0 = [NSArray arrayWithArray:(NSArray *)dict[@"highList"]];
        NSArray *array1 = [NSArray arrayWithArray:(NSArray *)dict[@"middleList"]];
        NSArray *array2 = [NSArray arrayWithArray:(NSArray *)dict[@"lowList"]];
        headerTitles = @[@"多发病症",@"可能病症",@"其他可能病症"];
        for (NSDictionary *dic in array0) {
            
            HYDSelfExDetailListModel *model = [[HYDSelfExDetailListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_highListArray addObject:model];
        }
        
        for (NSDictionary *dic in array1) {
            
            HYDSelfExDetailListModel *model = [[HYDSelfExDetailListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_middleListArray addObject:model];
        }
        
        for (NSDictionary *dic in array2) {
            
            HYDSelfExDetailListModel *model = [[HYDSelfExDetailListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_lowListArray addObject:model];
        }
        
        _dataArray = @[_highListArray,_middleListArray,_lowListArray].mutableCopy;
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma UITableView delegate dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dataArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDSelfExTopicListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    HYDSelfExDetailListModel *model = _dataArray[indexPath.section][indexPath.row];
    cell.titleLabel.text = model.diseaseName;
    cell.introLabel.text = model.diseaseIntro;
    if ([model.isWeiHu isEqualToString:@"1"]) {
        cell.nextImg.hidden = NO;
    }else {
        cell.nextImg.hidden = YES;
    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYDSelfExDetailListModel *model = _dataArray[indexPath.section][indexPath.row];
    
    if ([model.isWeiHu isEqualToString:@"1"]) {
        
        HYDSelfExDetailInfoVC *infoVC = [[HYDSelfExDetailInfoVC alloc]init];
        infoVC.diseaseId = model.diseaseId;
        infoVC.isWeiHu = model.isWeiHu;
        infoVC.title = model.diseaseName;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // 自定义header
    UIView *headView = [[UIView alloc]initWithFrame:_tableView.tableHeaderView.bounds];
    UILabel *markLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, HeaderViewHeight / 2 - 5, 10, 10)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 200, HeaderViewHeight)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = headerTitles[section];
    titleLabel.textColor = [UIColor blackColor];
    
    markLabel.layer.cornerRadius = 5;
    markLabel.layer.masksToBounds = YES;
    markLabel.backgroundColor = HYD_themeColor;
    
    headView.backgroundColor = [UIColor colorwithHexString:@"EEEDF3"];
    [headView addSubview:markLabel];
    [headView addSubview:titleLabel];
    
    return headView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if ([_dataArray[section] count] > 0) {
        
        return HeaderViewHeight;
    }
    return 0;
}

/* 去粘性 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = HeaderViewHeight;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
}

#pragma 自适应高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYDSelfExDetailListModel * model = _dataArray[indexPath.section][indexPath.row];
    return [self getCommentHeight:model];
}

- (CGFloat)getCommentHeight:(HYDSelfExDetailListModel *)commentModel
{
    CGFloat height = [self getStringSize:commentModel.diseaseIntro
                                        :CGSizeMake([[UIScreen mainScreen] bounds].size.width - 20, 10000)
                                        :[UIFont systemFontOfSize:12.f]].height;
    
    commentModel.cellHeight = height + 40;
    
    return height + 40;
}

- (CGSize) getStringSize:(NSString *)string :(CGSize)maxSize :(UIFont *)font {
    
    BOOL flag = [self stringIsEmpty:string];
    if (flag) {
        return CGSizeMake(0, 0);
    }
    
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesFontLeading
                                    attributes:dic
                                       context:nil].size;
    return size;
}

- (BOOL) stringIsEmpty:(NSString *)string {
    
    if ([string isKindOfClass:[NSNumber class]]) {
        NSNumber *stringNumber = (NSNumber *)string;
        string = [stringNumber stringValue];
    }
    if([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    if (string == nil) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] == 0) {
        return YES;
    }
    return NO;
}

@end
