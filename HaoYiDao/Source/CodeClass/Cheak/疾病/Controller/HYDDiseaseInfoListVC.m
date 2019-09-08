//
//  HYDDiseaseInfoListVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/31.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDDiseaseInfoListVC.h"
#import "HYDDiseaseInfoCell.h"
#import "HYDDiseaseInfoModel.h"
#import "HYDDiseaseInfoCollectionViewCell.h"
#import "HYDDrugInfoPopVC.h"
#import "HYDDiseaseCommon.h"

@interface HYDDiseaseInfoListVC ()<UITableViewDelegate,UITableViewDataSource,
UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSString *topicTitle;
}
@property (nonatomic,strong) NSMutableArray *drugsArray;
@property (nonatomic,strong) NSMutableArray *newsArray;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HYDDiseaseInfoListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupView];
    [self p_requestData];
}

- (void)p_setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  self.view.bounds.size.width,
                                                                  self.view.bounds.size.height - 64) style:(UITableViewStylePlain)];
    [_tableView registerClass:[HYDDiseaseInfoCell class] forCellReuseIdentifier:@"cell"];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (void)p_requestData {
    
    self.newsArray = [NSMutableArray array];
    self.drugsArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    __block NSDictionary *dictionary = [NSDictionary new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlString = [NSString stringWithFormat:HYDDiseaseListUrlTYPE_1,_dataID];
    if ([_dataType isEqualToString:@"2"]) {
        
        urlString = [NSString stringWithFormat:HYDDiseaseListUrlTYPE_2,_dataID];
    }

    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *drugList = [NSArray arrayWithArray:(NSArray *)dict[@"drugList"]];
        NSArray *newsList = [NSArray arrayWithArray:(NSArray *)dict[@"newsList"]];

        if ([_dataType isEqualToString:@"1"]) {
            
            topicTitle = [(NSDictionary *)[dict valueForKey:@"deseaseInfo"] valueForKey:@"content"];
            
        }else if ([_dataType isEqualToString:@"1"]) {
            
            topicTitle = [(NSDictionary *)[dict valueForKey:@"symptomInfo"] valueForKey:@"content"];
        }
        
        
        for (NSDictionary *dic in newsList) {
            
            HYDDiseaseInfoModel *model = [[HYDDiseaseInfoModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_newsArray addObject:model];
        }
        for (NSDictionary *dic in drugList) {
            
            HYDDiseaseInfoModel *model = [[HYDDiseaseInfoModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_drugsArray addObject:model];
        }
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma UITableView delegate dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _newsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDDiseaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    HYDDiseaseInfoModel *model = _newsArray[indexPath.row];
    cell.titleLabel.text = model.infoTitle;
    cell.infolabel.text = model.infoContent;
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:model.infoLogo] placeholderImage:[UIImage imageNamed:@"logo_button"]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYDDiseaseInfoModel *model = _newsArray[indexPath.row];
    NSString *urlString = [NSString stringWithFormat:DISEASE_NEWS_INFO_URL,model.infoId];
    HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
    vc.urlString = urlString;
    vc.Load_Type = LoadTypeNormalUrl;
    vc.title = model.infoTitle;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80 * HEIGHTSCALE;
}



/* 去粘性 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = [self getCommentHeight:topicTitle] + 100;//设置你footer高度
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                               0,
                                                               _tableView.bounds.size.width,
                                                               [self getCommentHeight:topicTitle] + 120)];
    
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,
                                                                  5,
                                                                  tableView.bounds.size.width - 20,
                                                                  [self getCommentHeight:topicTitle])];
    
    headLabel.text = topicTitle;
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
    UICollectionView *collectionView = [[UICollectionView alloc]
                                        initWithFrame:CGRectMake(0,
                                                                 CGRectGetMaxY(headLabel.frame),
                                                                 _tableView.bounds.size.width, 100)
                                        collectionViewLayout:layout];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[HYDDiseaseInfoCollectionViewCell class]
       forCellWithReuseIdentifier:@"collection"];
    
    [headView addSubview:collectionView];
    
    headView.backgroundColor = [UIColor colorwithHexString:@"#EEEDF3"];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  [self getCommentHeight:topicTitle] + 120;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _drugsArray.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDDiseaseInfoCollectionViewCell *cell = [collectionView
                                              dequeueReusableCellWithReuseIdentifier:@"collection"
                                              forIndexPath:indexPath];
    
    
    HYDDiseaseInfoModel *model = _drugsArray[indexPath.row];
    cell.nameLabel.text = model.drugName;
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.drugPic]
                           placeholderImage:[UIImage imageNamed:@"logo_button"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDDiseaseInfoModel *model = _drugsArray[indexPath.row];
    HYDDrugInfoPopVC *resultVC = [[HYDDrugInfoPopVC alloc]init];
    resultVC.introduce = model.promotionInfo;
    [self presentViewController:resultVC animated:YES completion:^{ }];
}

#pragma 自适应高度
- (CGFloat)getCommentHeight:(NSString *)string
{
    CGFloat height = [self getStringSize:string :CGSizeMake(_tableView.bounds.size.width - 20, 10000)
                                        :[UIFont fontWithName:@"STHeitiSC-Medium" size:14.f]].height;
    return height;
}

- (CGSize) getStringSize:(NSString *)string :(CGSize)maxSize :(UIFont *)font {
    
    BOOL flag = [self stringIsEmpty:string];
    if (flag) {
        return CGSizeMake(0, 0);
    }
    
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
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
