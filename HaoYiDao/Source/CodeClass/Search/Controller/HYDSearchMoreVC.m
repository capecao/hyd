//
//  HYDSearchMoreVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/12.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSearchMoreVC.h"
#import "HYDSearchCommon.h"

@interface HYDSearchMoreVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HYDSearchMoreVC

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    NSString *urlString = [NSString stringWithFormat:HYD_SEARCH_MORERESULT,_key,_type,0,20];

    [self p_setupTableView];
    [self p_setupData:urlString];
    [self p_refreshData];
}

- (void) p_setupData:(NSString *)urlString {
    
    __block NSDictionary *dictionary = [NSDictionary new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSDictionary *dict = [dictionary valueForKey:@"data"];
            NSDictionary *d = [dict valueForKey:@"searchResultList"];
            
            if ([d allKeys].count > 0)
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self p_pickData:d];
                });
            else{
                [_tableView.mj_footer endRefreshingWithNoMoreData];
                [ProgressHUD showError:@"没有更多..."];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    });
}

- (void) p_refreshData {
    
    __block int rows = 20;
    __block int start = 0;

    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        start += 20;
        rows += 20;
        NSString *urlString = [NSString stringWithFormat:HYD_SEARCH_MORERESULT,_key,_type,start,rows];
        [self p_setupData:urlString];
        
    }];
    
}

- (void) p_pickData:(NSDictionary *)dictionary {
    
    if ([_type isEqualToString:@"20"]){
        NSArray *array = [dictionary valueForKey:@"channelinfoList"];
        for (NSDictionary *dic in array) {
            HYDSearchResultModel *model = [[HYDSearchResultModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
    }else if ([_type isEqualToString:@"4"]) {
        NSArray *array = [dictionary valueForKey:@"symptomList"];
        for (NSDictionary *dic in array) {
            HYDSearchResultModel *model = [[HYDSearchResultModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
    }else if ([_type isEqualToString:@"3"]) {
        NSArray *array = [dictionary valueForKey:@"deseaseList"];
        for (NSDictionary *dic in array) {
            HYDSearchResultModel *model = [[HYDSearchResultModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
    }else if ([_type isEqualToString:@"2"]) {
        NSArray *array = [dictionary valueForKey:@"drugList"];
        for (NSDictionary *dic in array) {
            HYDSearchResultModel *model = [[HYDSearchResultModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
    }
    
    [_tableView reloadData];
    [_tableView.mj_footer endRefreshing];

}

- (void) p_setupTableView {
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0, 0, self.view.frame.size.width,
                                 self.view.frame.size.height - 64)
                                                 style:(UITableViewStyleGrouped)];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([_type isEqualToString:@"20"])
        [_tableView registerClass:[HYDSearchChannelCell class] forCellReuseIdentifier:@"channel"];
    if ([_type isEqualToString:@"4"])
        [_tableView registerClass:[HYDSearchDiseaseCell class] forCellReuseIdentifier:@"symptom"];
    if ([_type isEqualToString:@"3"])
        [_tableView registerClass:[HYDSearchDiseaseCell class] forCellReuseIdentifier:@"disease"];
    if ([_type isEqualToString:@"2"])
        [_tableView registerClass:[HYDSearchDrugCell class] forCellReuseIdentifier:@"drug"];
    
}


#pragma mark data&delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_type isEqualToString:@"20"])
    {
        HYDSearchResultModel *model = _dataArray[indexPath.row];
        
        HYDSearchChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"channel" forIndexPath:indexPath];
        cell.titLab.text = model.dataTitle;
        cell.infoLab.text = model.content;
        cell.likeLab.text = [NSString stringWithFormat:@"%@收藏",model.likeCount];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"logo_button"]];
        
        return cell;
        
    }
    if ([_type isEqualToString:@"4"])
    {
        HYDSearchResultModel *model = _dataArray[indexPath.row];
        
        HYDSearchDiseaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"symptom" forIndexPath:indexPath];
        
        cell.titLab.text = model.symptomName;
        cell.infoLab.text = model.symptomIntro;
        
        return cell;
        
    }
    if ([_type isEqualToString:@"3"])
    {
        HYDSearchResultModel *model = _dataArray[indexPath.row];
        
        HYDSearchDiseaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"disease" forIndexPath:indexPath];
        cell.titLab.text = model.deseaseName;
        cell.infoLab.text = model.deseaseIntro;
        
        return cell;
        
    }
    if ([_type isEqualToString:@"2"])
    {
        HYDSearchResultModel *model = _dataArray[indexPath.row];
        
        HYDSearchDrugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"drug" forIndexPath:indexPath];
        
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.drugPic]];
        
        if ([model.OTC isEqualToString:@"1"]) {
            
            [cell.counterImageView sd_setImageWithURL:[NSURL URLWithString:otcStr]];
            
        }else if ([model.OTC isEqualToString:@"0"]) {
            
            [cell.typeImageView sd_setImageWithURL:[NSURL URLWithString:unotcStr]];
        }
        
        if ([model.xiyao isEqualToString:@"1"]) {
            
            [cell.typeImageView sd_setImageWithURL:[NSURL URLWithString:xiyaoStr] placeholderImage:[UIImage imageNamed:@"logo_button"]];
            
        }else if([model.xiyao isEqualToString:@"0"])
        {
            
            [cell.typeImageView sd_setImageWithURL:[NSURL URLWithString:zhongyaoStr]];
        }
        cell.titleLabel.text = model.drugName;
        cell.infolabel.text = model.indication;
        
        return cell;
        
    }
 
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_type isEqualToString:@"2"]) {
        return 80 * HEIGHTSCALE;
    }
    return 90 * HEIGHTSCALE;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return .5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.5;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        HYDSearchResultModel *model = _dataArray[indexPath.row];
        HYDDrugInfoPopVC *vc = [[HYDDrugInfoPopVC alloc]init];
        vc.themeTitle = model.symptomName;
        vc.introduce = model.symptomIntro;
        [self presentViewController:vc animated:YES completion:nil];
        
    }else {
        
        HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
        NSString *urlString = @"";
        vc.Load_Type = LoadTypeNormalUrl;
        switch (indexPath.section) {
            case 0:
            {
                HYDSearchResultModel *model = _dataArray[indexPath.row];
                urlString = [NSString stringWithFormat:HYD_SEARCH_CHANNEL,model.dataId];
                vc.title = model.dataTitle;
            }
                break;
            case 2:
            {
                HYDSearchResultModel *model = _dataArray[indexPath.row];
                urlString = [NSString stringWithFormat:HYD_SEARCH_DISEASE,model.deseaseId];
                vc.title = model.deseaseName;
            }
                break;
            case 3:
            {
                HYDSearchResultModel *model = _dataArray[indexPath.row];
                urlString = [NSString stringWithFormat:HYD_SEARCH_DRUG,model.drugId];
                vc.title = model.drugName;
            }
                break;
            default:
                break;
        }
        vc.urlString = urlString;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



@end
