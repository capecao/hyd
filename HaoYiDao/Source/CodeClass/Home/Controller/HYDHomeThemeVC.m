//
//  HYDHomeThemeVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/2.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeThemeVC.h"
#import "HYDHomeThemeView.h"
#import "HYDHomeThemeCell.h"
#import "HYDHomeThemeModel.h"
#import "HYDHomePageCommon.h"


@interface HYDHomeThemeVC ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL flag1;
    BOOL flag2;
}
@property (nonatomic,strong) HYDHomeThemeView *itemView;
@property (nonatomic,strong) NSMutableArray *dataArray_0;
@property (nonatomic,strong) NSMutableArray *dataArray_1;
@property (nonatomic,strong) NSMutableArray *dataArray_2;
@property (nonatomic,strong) NSMutableArray *baseArray;

@end

@implementation HYDHomeThemeVC

- (void)loadView {
    [super loadView];
    
    self.itemView = [[HYDHomeThemeView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _itemView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self p_setupViewFeatures];

    [self p_requestBaseData];
}

- (void) p_setupViewFeatures {
    
    [self p_setupTableViewFeatures:_itemView.tableView0 :@"cell0"];
    [self p_setupTableViewFeatures:_itemView.tableView1 :@"cell1"];
    [self p_setupTableViewFeatures:_itemView.tableView2 :@"cell2"];
    
    _itemView.button0.tag = 10000;
    _itemView.button1.tag = 10001;
    _itemView.button2.tag = 10002;

    [_itemView.button0 addTarget:self action:@selector(p_itemViewButtonAct:) forControlEvents:UIControlEventTouchUpInside];
    [_itemView.button1 addTarget:self action:@selector(p_itemViewButtonAct:) forControlEvents:UIControlEventTouchUpInside];
    [_itemView.button2 addTarget:self action:@selector(p_itemViewButtonAct:) forControlEvents:UIControlEventTouchUpInside];

}

- (void) p_setupTableViewFeatures:(UITableView *)tableView :(NSString *)reuseId {
   
    [tableView registerClass:[HYDHomeThemeCell class] forCellReuseIdentifier:reuseId];
    tableView.dataSource = self;
    tableView.delegate = self;

}

- (void) p_itemViewButtonAct:(UIButton *)sender {
    NSInteger index = sender.tag - 10000;
    
    switch (index) {
        case 0:
        {
            _itemView.scrollView.contentOffset =
            CGPointMake(_itemView.scrollView.frame.origin.x, _itemView.scrollView.frame.origin.y);
        }
            break;
        case 1:
        {
            _itemView.scrollView.contentOffset =
            CGPointMake(_itemView.scrollView.frame.origin.x + SCREENWIDTH, _itemView.scrollView.frame.origin.y);
            if (!flag1) {
                self.dataArray_1 = [NSMutableArray array];
                [self p_requestDataIndex:index TableView:_itemView.tableView1];
            }
        }
            break;
        case 2:
        {
            _itemView.scrollView.contentOffset =
            CGPointMake(_itemView.scrollView.frame.origin.x + SCREENWIDTH * 2, _itemView.scrollView.frame.origin.y);
            if (!flag2) {
                self.dataArray_2 = [NSMutableArray array];
                [self p_requestDataIndex:index TableView:_itemView.tableView2];
            }
        }
            break;
        default:
            break;
    }
}

- (void) p_requestBaseData {
    
    self.baseArray = [NSMutableArray array];
    __block NSDictionary *dictionary = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
        NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"sections"]];
        
        for (NSDictionary *dic in array) {
            
            HYDHomeThemeModel *model = [[HYDHomeThemeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_baseArray addObject:model];
        }
        
        [self p_setupBaseDataView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}

- (void) p_setupBaseDataView {
    
    HYDHomeThemeModel *model0 = _baseArray[0];
    [_itemView.button0 setTitle:model0.title forState:(UIControlStateNormal)];
    HYDHomeThemeModel *model1 = _baseArray[1];
    [_itemView.button1 setTitle:model1.title forState:(UIControlStateNormal)];
    HYDHomeThemeModel *model2 = _baseArray[2];
    [_itemView.button2 setTitle:model2.title forState:(UIControlStateNormal)];
    
    self.dataArray_0 = [NSMutableArray array];
    [self p_requestDataIndex:0 TableView:_itemView.tableView0];
}

- (void) p_requestDataIndex:(NSInteger)index TableView:(UITableView *)tableView {
    
    HYDHomeThemeModel *model = _baseArray[index];
    __block NSDictionary *dictionary = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString = [NSString stringWithFormat:HOME_THEME_CLASS_URL,model.classId];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                         options:NSJSONReadingMutableContainers |
                          NSJSONReadingMutableLeaves
                                                           error:nil];
            if (dictionary)
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)dictionary[@"data"]];
                NSArray *array = [NSArray arrayWithArray:(NSArray *)dict[@"infos"]];
                switch (index) {
                    case 0:
                        _dataArray_0 = array.mutableCopy;
                        break;
                    case 1:
                    {
                        _dataArray_1 = array.mutableCopy;
                        flag1 = YES;
                    }
                        break;
                    case 2:
                    {
                        _dataArray_2 = array.mutableCopy;
                        flag2 = YES;
                    }
                        break;

                    default:
                        break;
                }
                [tableView reloadData];
                
            });

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@%@",self.nibName,error);
        }];
    });
}

#pragma mark UITableViewDataSource,UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([tableView isEqual:_itemView.tableView0]) {
        return _dataArray_0.count;
    }else if ([tableView isEqual:_itemView.tableView1]) {
        return _dataArray_1.count;
    }
    return _dataArray_2.count;
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([tableView isEqual:_itemView.tableView0]) {
        NSDictionary *dict =_dataArray_0[section];
        NSArray *array = (NSArray *)[dict valueForKey:@"infos"];
        return array.count;
    }else if ([tableView isEqual:_itemView.tableView1]) {
        NSDictionary *dict =_dataArray_1[section];
        NSArray *array = (NSArray *)[dict valueForKey:@"infos"];
        return array.count;
    }
    NSDictionary *dict =_dataArray_2[section];
    NSArray *array = (NSArray *)[dict valueForKey:@"infos"];
    return array.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_itemView.tableView0]) {
        
        HYDHomeThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
        
        NSDictionary *dict = _dataArray_0[indexPath.section];
        NSArray *array = (NSArray *)[dict valueForKey:@"infos"];
        HYDHomeThemeModel *model = [[HYDHomeThemeModel alloc]init];
        NSDictionary *dic = array[indexPath.row];
        [model setValuesForKeysWithDictionary:dic];
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]
                        placeholderImage:[UIImage imageNamed:@"logo_button"]];
        cell.titleLab.text = model.title;
        
        return cell;
        
    }else if ([tableView isEqual:_itemView.tableView1]) {
        
        HYDHomeThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
        NSDictionary *dict = _dataArray_1[indexPath.section];
        NSArray *array = (NSArray *)[dict valueForKey:@"infos"];
        HYDHomeThemeModel *model = [[HYDHomeThemeModel alloc]init];
        NSDictionary *dic = array[indexPath.row];
        [model setValuesForKeysWithDictionary:dic];
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]
                        placeholderImage:[UIImage imageNamed:@"logo_button"]];
        cell.titleLab.text = model.title;
        
        return cell;

    }
    
    HYDHomeThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    
    NSDictionary *dict = _dataArray_2[indexPath.section];
    NSArray *array = (NSArray *)[dict valueForKey:@"infos"];
    HYDHomeThemeModel *model = [[HYDHomeThemeModel alloc]init];
    NSDictionary *dic = array[indexPath.row];
    [model setValuesForKeysWithDictionary:dic];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]
                    placeholderImage:[UIImage imageNamed:@"logo_button"]];
    cell.titleLab.text = model.title;
    
    return cell;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCREENHEIGHT * .3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44 * HEIGHTSCALE;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width,
                                                           44 * HEIGHTSCALE)];
    head.backgroundColor = [UIColor colorwithHexString:@"#f3f3f3"];
    
    UIImageView *img0 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, head.bounds.size.width / 3,
                                                                     CGRectGetHeight(head.bounds))];
    UILabel *titLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(img0.frame) + 15 * WIDTHTSCALE,
                                                               10 * HEIGHTSCALE,
                                                               head.bounds.size.width / 3 - 30 * WIDTHTSCALE,
                                                               24 * HEIGHTSCALE)];
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titLab.frame) + 15 * WIDTHTSCALE,
                                                                     0, head.bounds.size.width / 3,
                                                                     CGRectGetHeight(head.bounds))];

    [head addSubview:img0];
    [head addSubview:titLab];
    [head addSubview:img1];
    
    img0.image = [UIImage imageNamed:@"homeItemHead_left"];
    img1.image = [UIImage imageNamed:@"homeItemHead_right"];
    
    titLab.layer.masksToBounds = YES;
    titLab.layer.cornerRadius = titLab.frame.size.height * .5;
    titLab.backgroundColor = [UIColor colorwithHexString:@"#cdcdcd"];
    titLab.textColor = [UIColor whiteColor];
    titLab.textAlignment = NSTextAlignmentCenter;
    
    NSDictionary *dict = _dataArray_0[section];
    NSString *day = (NSString *)[dict valueForKey:@"day"];
    titLab.text = day;
    
    return head;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = [NSDictionary dictionary];
    if ([tableView isEqual:_itemView.tableView0])
       dict =_dataArray_0[indexPath.section];
        
    else if ([tableView isEqual:_itemView.tableView1])
        dict =_dataArray_1[indexPath.section];

    else if ([tableView isEqual:_itemView.tableView2])
        dict =_dataArray_2[indexPath.section];

    NSArray *array = (NSArray *)[dict valueForKey:@"infos"];
    HYDHomeThemeModel *model = [[HYDHomeThemeModel alloc]init];
    NSDictionary *dic = array[indexPath.row];
    [model setValuesForKeysWithDictionary:dic];
    
    HYDHTMLWebVC *vc = [[HYDHTMLWebVC alloc]init];
    vc.urlString = [NSString stringWithFormat:HOME_THEME_INFO_URL,model.id];
    vc.Load_Type = LoadTypeNormalUrl;
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
