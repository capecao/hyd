//
//  HYDSearchResultVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/10.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSearchResultVC.h"
#import "HYDSearchCommon.h"
#import "HYDDrugInfoPopVC.h"
#import "HYDSearchMoreVC.h"

@interface HYDSearchResultVC ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat height_footerheader;
}
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *drugList;
@property (nonatomic,strong) NSMutableArray *diseaseList;
@property (nonatomic,strong) NSMutableArray *channelinfoList;
@property (nonatomic,strong) NSMutableArray *symptomList;
@property (nonatomic,strong) NSMutableArray *flagArray;
@property (nonatomic,strong) NSMutableArray *markArray;

@end

@implementation HYDSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    height_footerheader = 35 * HEIGHTSCALE;
    [self p_searchResultdata];
    [self p_setupTableView];
}

- (void) p_searchResultdata {
    
    self.drugList = [NSMutableArray array];
    self.diseaseList = [NSMutableArray array];
    self.channelinfoList = [NSMutableArray array];
    self.symptomList = [NSMutableArray array];
    
    for (NSDictionary *dictionary in _dataArray) {
        NSDictionary *dict = [dictionary valueForKey:@"doclist"];
        NSString *key = [dictionary valueForKey:@"groupValue"];

        if ([key isEqualToString:@"2"]) {
            NSArray *array = [dict valueForKey:@"drugList"];
            for (NSDictionary *dic in array) {
                HYDSearchResultModel *model = [[HYDSearchResultModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [_drugList addObject:model];
            }
        }else if ([key isEqualToString:@"3"]) {
            
            NSArray *array = [dict valueForKey:@"deseaseList"];
            for (NSDictionary *dic in array) {
                HYDSearchResultModel *model = [[HYDSearchResultModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [_diseaseList addObject:model];
            }
        }else if ([key isEqualToString:@"20"]) {
            
            NSArray *array = [dict valueForKey:@"channelinfoList"];
            for (NSDictionary *dic in array) {
                HYDSearchResultModel *model = [[HYDSearchResultModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [_channelinfoList addObject:model];
            }
        }else if ([key isEqualToString:@"4"]) {
            
            NSArray *array = [dict valueForKey:@"symptomList"];
            for (NSDictionary *dic in array) {
                HYDSearchResultModel *model = [[HYDSearchResultModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                if (model.symptomName.length && model.symptomIntro.length)
                    [_symptomList addObject:model];
            }
        }
    }
    
    self.flagArray = [NSMutableArray array];
    self.markArray = [NSMutableArray array];
    
    if (_channelinfoList.count > 0) {
        [_flagArray addObject:_channelinfoList];
        [_markArray addObject:@"相关文章"];
    }
    if (_symptomList.count > 0) {
        [_flagArray addObject:_symptomList];
        [_markArray addObject:@"相关症状"];
    }
    if (_diseaseList.count > 0) {
        [_flagArray addObject:_diseaseList];
        [_markArray addObject:@"相关疾病"];
    }
    if (_drugList.count > 0) {
        [_flagArray addObject:_drugList];
        [_markArray addObject:@"相关商品"];
    }
    
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
    
    [_tableView registerClass:[HYDSearchChannelCell class] forCellReuseIdentifier:@"channel"];
    [_tableView registerClass:[HYDSearchDiseaseCell class] forCellReuseIdentifier:@"disease"];
    [_tableView registerClass:[HYDSearchDrugCell class] forCellReuseIdentifier:@"drug"];
    [_tableView registerClass:[HYDSearchDiseaseCell class] forCellReuseIdentifier:@"symptom"];

}

#pragma mark data&delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return _flagArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *array = _flagArray[section];
    return array.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *array = _flagArray[indexPath.section];
    if ([array isEqualToArray:_channelinfoList]) {
        
        HYDSearchResultModel *model = _channelinfoList[indexPath.row];
        
        HYDSearchChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"channel" forIndexPath:indexPath];
        cell.titLab.text = model.dataTitle;
        cell.infoLab.text = model.content;
        cell.likeLab.text = [NSString stringWithFormat:@"%@收藏",model.likeCount];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"logo_button"]];
        
        return cell;
        
    }
    else if ([array isEqualToArray:_symptomList]){
        HYDSearchResultModel *model = _symptomList[indexPath.row];
        
        HYDSearchDiseaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"symptom" forIndexPath:indexPath];
        cell.titLab.text = model.symptomName;
        cell.infoLab.text = model.symptomIntro;
        
        return cell;
        
    }
    else if ([array isEqualToArray:_diseaseList]){
        HYDSearchResultModel *model = _diseaseList[indexPath.row];
        
        HYDSearchDiseaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"disease" forIndexPath:indexPath];
        cell.titLab.text = model.deseaseName;
        cell.infoLab.text = model.deseaseIntro;
        
        return cell;
        
    }
    else if ([array isEqualToArray:_drugList]){
        
        HYDSearchResultModel *model = _drugList[indexPath.row];
        
        HYDSearchDrugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"drug" forIndexPath:indexPath];
        
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.drugPic] placeholderImage:[UIImage imageNamed:@"logo_button"]];
        cell.titleLabel.text = model.drugName;
        
        if ([model.OTC isEqualToString:@"1"]) {
            
            [cell.counterImageView sd_setImageWithURL:[NSURL URLWithString:otcStr]];
            
        }else if ([model.OTC isEqualToString:@"0"]) {
            
            [cell.typeImageView sd_setImageWithURL:[NSURL URLWithString:unotcStr]];
        }
        
        if ([model.xiyao isEqualToString:@"1"]) {
            
            [cell.typeImageView sd_setImageWithURL:[NSURL URLWithString:xiyaoStr] placeholderImage:[UIImage imageNamed:@"logo_button"]];
            
        }else if([model.xiyao isEqualToString:@"0"]){
            
            [cell.typeImageView sd_setImageWithURL:[NSURL URLWithString:zhongyaoStr]];cell.titleLabel.text = model.drugName;
            cell.infolabel.text = model.indication;
        }
        
        return cell;
        
    }
    
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return 80 * HEIGHTSCALE;
    }
    return 90 * HEIGHTSCALE;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return height_footerheader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return height_footerheader;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height_footerheader)];
    footer.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton *moreBt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    moreBt.frame = CGRectMake(footer.frame.size.width * .6, 0,
                              footer.frame.size.width * .4,
                              footer.frame.size.height);
    [footer addSubview:moreBt];
    moreBt.tag = 11111 + section;
    NSString *title = [NSString stringWithFormat:@"更多%@ >>",_markArray[section]];
    [moreBt setTitle:title forState:(UIControlStateNormal)];
    [moreBt setTitleColor:HYD_themeColor forState:(UIControlStateNormal)];
    [moreBt addTarget:self action:@selector(moreBtAct:)
     forControlEvents:(UIControlEventTouchUpInside)];
    
    return footer;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc]initWithFrame:
                      CGRectMake(0, 0,
                                 self.tableView.frame.size.width,
                                 height_footerheader)];
    
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(10 * WIDTHTSCALE, 0, header.frame.size.width - 20 * WIDTHTSCALE, header.frame.size.height);
    label.font = HYD_font(15.f);
    label.text = _markArray[section];
    [header addSubview:label];
    
    UIView *line = [[UIView alloc]init];
    line.frame = CGRectMake(0,
                            header.frame.size.height - .5,
                            header.frame.size.width,
                            .5);
    line.backgroundColor = HYD_themeColor;
    [header addSubview:line];
    
    return header;
}

- (void) moreBtAct:(UIButton *)sender {
    
    HYDSearchMoreVC *vc = [[HYDSearchMoreVC alloc]init];
    int index = 20;
    NSString *title = _markArray[sender.tag - 11111];
    
    switch (sender.tag - 11111) {
        case 0:
        {
            index = 20;
        }
            break;
        case 1:
        {
            index = 4;
        }
            break;
        case 2:
        {
            index = 3;
        }
            break;
        case 3:
        {
            index = 2;
        }
            break;
        default:
            break;
    }
    
    vc.type = [NSString stringWithFormat:@"%d",index];
    vc.title = title;
    vc.key = [self.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [self.navigationController pushViewController:vc animated:YES];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *array = _flagArray[indexPath.section];
    
    if ([array isEqualToArray:_symptomList]) {
        
        HYDSearchResultModel *model = _symptomList[indexPath.row];
        HYDDrugInfoPopVC *vc = [[HYDDrugInfoPopVC alloc]init];
        vc.themeTitle = model.symptomName;
        vc.introduce = model.symptomIntro;
        [self presentViewController:vc animated:YES completion:nil];
        
    }else {
        
        HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
        NSString *urlString = @"";
        vc.Load_Type = LoadTypeNormalUrl;
        
        if ([array isEqualToArray:_channelinfoList])
        {
            HYDSearchResultModel *model = _channelinfoList[indexPath.row];
            urlString = [NSString stringWithFormat:HYD_SEARCH_CHANNEL,model.dataId];
            vc.title = model.dataTitle;
        }
        else if ([array isEqualToArray:_diseaseList])
        {
            HYDSearchResultModel *model = _diseaseList[indexPath.row];
            urlString = [NSString stringWithFormat:HYD_SEARCH_DISEASE,model.deseaseId];
            vc.title = model.deseaseName;
        }
        else if ([array isEqualToArray:_drugList])
        {
            HYDSearchResultModel *model = _drugList[indexPath.row];
            urlString = [NSString stringWithFormat:HYD_SEARCH_DRUG,model.drugId];
            vc.title = model.drugName;
        }
        
        vc.urlString = urlString;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
