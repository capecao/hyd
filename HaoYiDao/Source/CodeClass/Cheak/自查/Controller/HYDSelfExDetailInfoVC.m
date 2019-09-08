//
//  HYDSelfExDetailInfoVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/30.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSelfExDetailInfoVC.h"
#import "HYDSelExDetailInfoCell.h"
#import "HYDSelExDetailInfoModel.h"
#import "HYDSelfExamationCommon.h"
#import "HYDSelfExDrugCollectionViewCell.h"
#import "HYDDrugInfoPopVC.h"

@interface HYDSelfExDetailInfoVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSString *_content;
    
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *DrugsArray;

@end

@implementation HYDSelfExDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_requestData];
    [self p_setupView];
}

- (void) p_setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [_tableView registerClass:[HYDSelExDetailInfoCell class] forCellReuseIdentifier:@"cell"];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void) p_requestData {
    
    self.dataArray = [NSMutableArray new];
    self.DrugsArray = [NSMutableArray new];

    __weak typeof(self) weakSelf = self;
    __block NSDictionary *dictionary = [NSDictionary new];
    
    NSString *urlString = [NSString stringWithFormat:SelfExDetailInfotUrl,_diseaseId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"newsList"]];
        _content = dict[@"deseaseInfo"][@"content"];
        NSArray *array0 = [NSArray arrayWithArray:(NSArray *)dict[@"drugList"]];

        for (NSDictionary *dic in array) {
            
            HYDSelExDetailInfoModel *model = [[HYDSelExDetailInfoModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        for (NSDictionary *dic in array0) {
            
            HYDSelExDetailInfoModel *model = [[HYDSelExDetailInfoModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_DrugsArray addObject:model];
        }
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma UITableView delegate dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDSelExDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                                   forIndexPath:indexPath];
    
    HYDSelExDetailInfoModel *model = _dataArray[indexPath.row];
    cell.titleLabel.text = model.infoTitle;
    cell.infolabel.text = model.infoContent;
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:model.infoLogo] placeholderImage:[UIImage imageNamed:@"logo_button"]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    HYDSelExDetailInfoModel *model = _dataArray[indexPath.row];
    NSString *urlString = [NSString stringWithFormat:SELFEX_NEWS_INFO_URL,model.infoId];
    HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
    vc.Load_Type = LoadTypeNormalUrl;
    vc.urlString = urlString;
    vc.title = model.infoTitle;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}



/* 去粘性 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = [self getCommentHeight:_content] + 100;//设置你footer高度
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, [self getCommentHeight:_content] + 120)];
    
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, tableView.bounds.size.width - 20, [self getCommentHeight:_content])];
    headLabel.text = _content;
    headLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14.f];
    headLabel.numberOfLines = 0;
    [headView addSubview:headLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 100);
    //水平滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //上左下右四个偏移量
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //每个cell之间的间距
    layout.minimumInteritemSpacing = 10.0;
    UICollectionView *collectionView = [[UICollectionView
                                         alloc]initWithFrame:CGRectMake(0,
                                                                        CGRectGetMaxY(headLabel.frame),
                                                                        _tableView.bounds.size.width,
                                                                        100)
                                        collectionViewLayout:layout];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[HYDSelfExDrugCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
    [headView addSubview:collectionView];
    
    headView.backgroundColor = [UIColor colorwithHexString:@"#EEEDF3"];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  [self getCommentHeight:_content] + 120;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _DrugsArray.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView
                   cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDSelfExDrugCollectionViewCell *cell = [collectionView
                                             dequeueReusableCellWithReuseIdentifier:@"collection"
                                             forIndexPath:indexPath];
    
    HYDSelExDetailInfoModel *model = _DrugsArray[indexPath.row];
    cell.titleLabel.text = model.drugName;
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.drugPic]
                           placeholderImage:[UIImage imageNamed:@"logo_button"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDSelExDetailInfoModel *model = _DrugsArray[indexPath.row];
    HYDDrugInfoPopVC *resultVC = [[HYDDrugInfoPopVC alloc]init];
    resultVC.introduce = model.promotionInfo;
    resultVC.themeTitle = @"主治功能";
    [self presentViewController:resultVC animated:YES completion:^{ }];
}

#pragma 自适应高度
- (CGFloat)getCommentHeight:(NSString *)string
{
    CGFloat height = [self getStringSize:string
                                        :CGSizeMake(_tableView.bounds.size.width - 20, 10000)
                                        :[UIFont fontWithName:@"STHeitiSC-Medium" size:14.f]].height;
    return height;
}

- (CGSize) getStringSize:(NSString *)string :(CGSize)maxSize :(UIFont *)font {
    
    BOOL flag = [self stringIsEmpty:string];
    if (flag) {
        return CGSizeMake(0, 0);
    }
    
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:maxSize
                                       options:NSStringDrawingUsesLineFragmentOrigin |
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
