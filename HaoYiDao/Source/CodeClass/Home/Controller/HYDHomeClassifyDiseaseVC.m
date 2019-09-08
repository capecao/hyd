//
//  HYDHomeClassifyDiseaseVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeClassifyDiseaseVC.h"
#import "HYDHomeClassifyDiseaseCell.h"
#import "HYDDrugList_2Model.h"
#import "HYDDrugList_2Cell.h"
#import "HYDHomePageCommon.h"


@interface HYDHomeClassifyDiseaseVC () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *drugLists;
@property (nonatomic,copy)  NSString *deseaseIntro;
@property (nonatomic,copy)  NSString *deseaseName;

@end

@implementation HYDHomeClassifyDiseaseVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_requestBaseData];

}

- (void) p_setupTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.tableView registerClass:[HYDDrugList_2Cell class] forCellReuseIdentifier:@"cell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];

}

- (void) p_requestBaseData {
    
    __weak typeof(self) weakSelf = self;
    __block NSDictionary *dictionary = [NSDictionary new];
    
    NSString *urlString = [NSString stringWithFormat:HOME_CLASSIFY_DESEASE,_deseaseId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [[NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]] valueForKey:@"deseaseInfo"];
        
        self.deseaseIntro = [dict valueForKey:@"deseaseIntro"];
        self.deseaseName = [dict valueForKey:@"deseaseName"];
        
        if (weakSelf.deseaseIntro) {
            
            [self p_setupTableView];
            [self p_requestData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void) p_requestData {
    
    self.drugLists = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    __block NSDictionary *dictionary = [NSDictionary new];
    
    NSString *urlString = [NSString stringWithFormat:HOME_CLASSIFY_DESEASEINFO_DRUGS,_deseaseId];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"drugList"]];
        
        for (NSDictionary *dic in array) {
            
            HYDDrugList_2Model *model = [[HYDDrugList_2Model alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_drugLists addObject:model];
        }
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _drugLists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDDrugList_2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    HYDDrugList_2Model *model = _drugLists[indexPath.row];
    
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

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85 * HEIGHTSCALE;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [self heightForText:_deseaseIntro] + 60 * HEIGHTSCALE;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width,
                                                           [self heightForText:_deseaseIntro] + 40 * HEIGHTSCALE)];
    
    UILabel *titLab = [[UILabel alloc]initWithFrame:CGRectMake(5 * WIDTHTSCALE, 5 * HEIGHTSCALE,
                                                               head.frame.size.width - 10 * WIDTHTSCALE,
                                                               30 * HEIGHTSCALE)];
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titLab.frame),
                                                                 CGRectGetMaxY(titLab.frame),
                                                                 CGRectGetWidth(titLab.frame),
                                                                 [self heightForText:_deseaseIntro])];
    
    titLab.font = HYD_font_MEDIUM(12.f);
    titLab.text = _deseaseName;
    
    infoLab.font = HYD_font(12.f);
    infoLab.numberOfLines = 0;
    infoLab.lineBreakMode = NSLineBreakByTruncatingTail;
    infoLab.text = _deseaseIntro;
    
    [head addSubview:titLab];
    [head addSubview:infoLab];
    
    UIButton *moreBt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    moreBt.frame = CGRectMake(head.frame.size.width - 60 * WIDTHTSCALE,
                              CGRectGetMaxY(infoLab.frame),
                              60 * WIDTHTSCALE, 30 * HEIGHTSCALE);
    
    [moreBt setTitleColor:HYD_themeColor forState:(UIControlStateNormal)];
    moreBt.titleLabel.font = HYD_font_DONGQING(14.f);
    [moreBt setTitle:@"更多>>" forState:(UIControlStateNormal)];
    [head addSubview:moreBt];
    [moreBt addTarget:self action:@selector(morebtAct:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return head;
}

- (void) morebtAct:(UIButton *)sender {
    
    HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
    vc.urlString = [NSString stringWithFormat:HOME_CLASSIFY_DESEASEINFO,_deseaseId];
    vc.Load_Type = LoadTypeNormalUrl;
    vc.title = self.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
    HYDDrugList_2Model *model = _drugLists[indexPath.row];
    vc.Load_Type = LoadTypeNormalUrl;
    vc.title = model.drugName;
    vc.urlString = [NSString stringWithFormat:HOME_CLASSIFY_DRUG,model.drugId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat) heightForText:(NSString *)str {
    
   CGRect size = [_deseaseIntro boundingRectWithSize:CGSizeMake(_tableView.frame.size.width - 10 * WIDTHTSCALE, 2000)
                                             options:(NSStringDrawingUsesLineFragmentOrigin)
                                          attributes:@{NSFontAttributeName :HYD_font(12.f)}
                                             context:nil];
    return size.size.height;
}

/* 去掉UItableview headerview黏性(sticky) */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = [self heightForText:_deseaseIntro] + 60 * HEIGHTSCALE;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
}

@end
