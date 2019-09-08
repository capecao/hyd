//
//  HYDDistrictHospitalsVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/23.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDDistrictHospitalsVC.h"
#import "HYDHomeClassifyCell.h"

@interface HYDDistrictHospitalsVC ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat width;
    CGFloat height;
}
@property (nonatomic,strong) UITableView *tableView0;
@property (nonatomic,strong) UITableView *tableView1;
@property (nonatomic,strong) UITableView *tableView2;
@property (nonatomic,strong) NSMutableArray *dataArray0;
@property (nonatomic,strong) NSMutableArray *dataArray1;
@property (nonatomic,strong) NSMutableArray *dataArray2;
@property (nonatomic,strong) NSMutableArray *selectedArray;
@property (nonatomic,strong) NSDictionary *addressDic;

@end

@implementation HYDDistrictHospitalsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self p_redAddressPlist];
    [self p_setupViews];
}

- (void) p_setupViews {
    
    width = self.view.frame.size.width / 3;
    height = 40 * HEIGHTSCALE;
    
    
    NSArray *colors = @[[UIColor colorwithHexString:@"#FF758C"],
                        [UIColor colorwithHexString:@"#f6e700"],
                        [UIColor colorwithHexString:@"#2cf4a6"]];
    for (int i = 0; i < 3; i ++) {
        
        UILabel *titLab = [[UILabel alloc]init];
        titLab.frame = CGRectMake(width * i, 0, width * .8, height);
        titLab.tag = 100 + i;
        titLab.backgroundColor = colors[i];
        titLab.font = HYD_font_MEDIUM(12.f);
        titLab.textAlignment = NSTextAlignmentCenter;
        titLab.textColor = [UIColor whiteColor];
        [self.view addSubview:titLab];
        
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(CGRectGetMaxX(titLab.frame), 0, width * .2, height);
        [button setImage:[UIImage imageNamed:@"icon_address_select"] forState:(UIControlStateNormal)];
        button.backgroundColor = [UIColor colorwithHexString:@"#414141"];
        button.tag = 200 + i;
        [self.view addSubview:button];
        [button addTarget:self
                   action:@selector(buttonAct:)
         forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    self.tableView0 = [[UITableView alloc]init];
    self.tableView1 = [[UITableView alloc]init];
    self.tableView2 = [[UITableView alloc]init];
    
    CGRect frame0 = CGRectMake(0, height, width,
                               self.view.frame.size.height - 64 - height);
    CGRect frame1 = CGRectMake(width, CGRectGetMinY(frame0),
                               CGRectGetWidth(frame0), CGRectGetHeight(frame0));
    CGRect frame2 = CGRectMake(width * 2, CGRectGetMinY(frame0),
                               CGRectGetWidth(frame0), CGRectGetHeight(frame0));

    [self p_setupTableView:_tableView0 :@"cell0" :frame0];
    [self p_setupTableView:_tableView1 :@"cell1" :frame1];
    [self p_setupTableView:_tableView2 :@"cell2" :frame2];

}

- (void) buttonAct:(UIButton *)sender {
    
    _tableView0.hidden = NO;
    
    [UIView animateWithDuration:1 animations:^{
        _tableView0.bottom = 40 * HEIGHTSCALE;
    }];
    _tableView0.frame = CGRectMake(0, height, width,
                                   self.view.frame.size.height - height);
    
}

- (void) p_setupTableView:(UITableView *)tableView :(NSString *)cell :(CGRect)frame {
    
    [tableView registerClass:[HYDHomeClassifyCell class] forCellReuseIdentifier:cell];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.frame = frame;
    [self.view addSubview:tableView];
    tableView.hidden = YES;
}

- (void) p_redAddressPlist {
    
    self.dataArray0 = [NSMutableArray array];
    self.dataArray1 = [NSMutableArray array];
    self.dataArray2 = [NSMutableArray array];
    self.selectedArray = [NSMutableArray array];
    self.addressDic = [NSMutableDictionary dictionary];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address"
                                                     ofType:@"plist"];
    _addressDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    _dataArray0 = [_addressDic allKeys].mutableCopy;
    
    _selectedArray = [_addressDic objectForKey:[_dataArray0 objectAtIndex:0]];
    
    if (_selectedArray.count > 0) {
        _dataArray1 = [[self.selectedArray objectAtIndex:0] allKeys].mutableCopy;
    }
    if (_dataArray1.count > 0) {
        _dataArray2 = [[self.selectedArray objectAtIndex:0] objectForKey:[_dataArray1 objectAtIndex:0]];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:_tableView0]) {
        return _dataArray0.count;
    }else if ([tableView isEqual:_tableView1]) {
        return _dataArray1.count;
    }else if ([tableView isEqual:_tableView2]) {
        return _dataArray2.count;
    }

    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_tableView0]) {
        HYDHomeClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
        cell.titleLab.text = _dataArray0[indexPath.row];
    
        return cell;
    
    }else if ([tableView isEqual:_tableView1]) {
        HYDHomeClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.titleLab.text = _dataArray1[indexPath.row];
        
        return cell;
    }else if ([tableView isEqual:_tableView2]) {
        HYDHomeClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.titleLab.text = _dataArray2[indexPath.row];
        
        return cell;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 36 * HEIGHTSCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_tableView0]) {
        
        _tableView1.hidden = NO;
        [UIView animateWithDuration:1 animations:^{
            _tableView1.bottom = 40 * HEIGHTSCALE;
        }];
        
        _tableView1.frame = CGRectMake(width, height, width,
                                       self.view.frame.size.height - height);
        _selectedArray = [_addressDic objectForKey:[_dataArray0 objectAtIndex:indexPath.row]];
        if (_selectedArray.count)
        {
            _dataArray1 = [[_selectedArray objectAtIndex:0] allKeys].mutableCopy;
        }
        
        UILabel *label = [self.view viewWithTag:100];
        label.text = _dataArray0[indexPath.row];

    }else if ([tableView isEqual:_tableView1]) {
        
        _tableView2.hidden = NO;
        [UIView animateWithDuration:1 animations:^{
            _tableView2.bottom = 40 * HEIGHTSCALE;
        }];
        _tableView2.frame = CGRectMake(width * 2, height, width,
                                       self.view.frame.size.height - height);
        
        if (_dataArray1.count > 0) {
            _dataArray2 = [[_selectedArray objectAtIndex:0] objectForKey:[_dataArray1 objectAtIndex:indexPath.row]];
        }
        
        UILabel *label = [self.view viewWithTag:101];
        label.text = _dataArray1[indexPath.row];

    }else if ([tableView isEqual:_tableView2]) {

        UILabel *label = [self.view viewWithTag:102];
        label.text = _dataArray2[indexPath.row];
        
        [_tableView0 setHidden:YES];
        [_tableView1 setHidden:YES];
        [_tableView2 setHidden:YES];
    }
    
    [tableView reloadData];

}

@end
