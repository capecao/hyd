//
//  YSLMangerViewController.m
//  HaoYiDao
//
//  Created by capecao on 16/9/22.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "YSLMangerViewController.h"
#import "HYDHomeClassifyCell.h"
#import "YSLNewsMenuManger.h"

@interface YSLMangerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat heightForHeader;
}
@property (nonatomic,strong) NSMutableArray *selectArray;
@property (nonatomic,strong) NSMutableArray *currentArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *compareArray;

@end

@implementation YSLMangerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self p_getPlistData];
    [self p_setupView];
}

- (void) p_getPlistData {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HYDNewsCategory" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *array = [data valueForKey:@"channel"];
    NSMutableArray *plistArray = [NSMutableArray arrayWithArray:array];
 
#pragma mark 设置已添加和未添加的item数组
    
    self.currentArray = [[YSLNewsMenuManger shareInstance] findAll].mutableCopy;
    self.compareArray = [[YSLNewsMenuManger shareInstance] findAll].mutableCopy;
    
    // 整除计算高度
    [self heightOfHeader];

    self.selectArray = [NSMutableArray array];
    NSMutableIndexSet *tempSet = [NSMutableIndexSet indexSet];

    for (int i = 0; i < plistArray.count; i ++) {
        NSDictionary *dic = plistArray[i];
        for (int j = 0; j < _currentArray.count; j ++) {
            NewsMenuModel *model = _currentArray[j];
            unsigned long index = i;
            if ([model.channelName isEqualToString:[dic valueForKey:@"channelName"]]) {
                [tempSet addIndex:index];
            }
        }
    }
#pragma mark removeObjectsAtIndexes 不错
    [plistArray removeObjectsAtIndexes:tempSet];
    _selectArray = plistArray;
}

- (void) p_setupView {
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
    self.tableView = [[UITableView alloc]initWithFrame:frame style:(UITableViewStylePlain)];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerClass:[HYDHomeClassifyCell class] forCellReuseIdentifier:@"cell"];
    _tableView.showsVerticalScrollIndicator = NO;
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _selectArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHomeClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                                forIndexPath:indexPath];
    NSDictionary *d = _selectArray[indexPath.row];
    cell.titleLab.text = [d valueForKey:@"channelName"];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 36 * HEIGHTSCALE;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return heightForHeader;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc]init];
    header.frame = CGRectMake(0 * WIDTHTSCALE, 0,
                              _tableView.frame.size.width,
                              heightForHeader);
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *titLba = [[UILabel alloc]initWithFrame:
                       CGRectMake(0, 0,
                                  header.frame.size.width,
                                  40 * HEIGHTSCALE)];
    titLba.font = HYD_font_MEDIUM(14.f);
    titLba.textColor = [UIColor colorwithHexString:@"#414141"];
    titLba.backgroundColor = [UIColor groupTableViewBackgroundColor];
    titLba.text = @"  已选栏目:";
    [header addSubview:titLba];
    
    NSInteger count = _currentArray.count / 4;
    CGFloat quarterW = header.frame.size.width * .25;
    CGFloat averageH = titLba.frame.size.height;
    CGFloat width = 70 * WIDTHTSCALE;
    CGFloat height = 30 * HEIGHTSCALE;
    
    NewsMenuModel *model = _currentArray[0];
    if (![model.channelName isEqualToString:@"头条"]){
        int origin = 0;
        for (int i = 0;i < _currentArray.count; i++) {
            NewsMenuModel *model = _currentArray[i];
            if ([model.channelName isEqualToString:@"头条"])
                origin = i;
            
        }
        [_currentArray exchangeObjectAtIndex:origin withObjectAtIndex:0];
    }

    for (int i = 0; i < count + 1; i ++) {
        for (int j = 0; j < 4; j ++) {
            
            if (4 * i + j < _currentArray.count) {
                
                NewsMenuModel *model = _currentArray[4 * i + j];
                UIButton *button = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
                button.frame = CGRectMake(quarterW * .5 - width * .5 + j * quarterW,
                                          CGRectGetMaxY(titLba.frame) + 5 * HEIGHTSCALE +
                                          i *averageH, width, height);
                button.layer.cornerRadius = height * .5;
                button.layer.borderWidth = .5;
                button.layer.borderColor = HYD_themeColor.CGColor;
                button.layer.masksToBounds = 1;
                [button setTitleColor:HYD_themeColor forState:(UIControlStateNormal)];
                button.titleLabel.font = HYD_font_MEDIUM(12.f);
                [button setTitle:model.channelName forState:(UIControlStateNormal)];
                button.tag = 100 + 4 * i + j;
                [header addSubview:button];
                [button addTarget:self action:@selector(buttonAct:)
                 forControlEvents:(UIControlEventTouchUpInside)];
            }
        }
    }
    
    
    UILabel *tailLba = [[UILabel alloc]initWithFrame:
                       CGRectMake(0, heightForHeader - 40 * HEIGHTSCALE,
                                  header.frame.size.width,
                                  40 * HEIGHTSCALE)];
    tailLba.font = HYD_font_MEDIUM(14.f);
    tailLba.textColor = [UIColor colorwithHexString:@"#414141"];
    tailLba.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tailLba.text = @"  未选栏目:";
    [header addSubview:tailLba];
    
    return header;
}

- (void) buttonAct:(UIButton *)sender {
    
    NSInteger index = sender.tag - 100;
    NewsMenuModel *model = _currentArray[index];
    if (![model.channelName isEqualToString:@"头条"]) {
        [_currentArray removeObjectAtIndex:index];
        NSDictionary *d = @{@"channelName":model.channelName,
                            @"channelName":model.channelId,@"channelName":model.channelType};
        [_selectArray addObject:d];
        [self heightOfHeader];
        [_tableView reloadData];
        
        [[YSLNewsMenuManger shareInstance] removeNewsMenuModel:model];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *d = _selectArray[indexPath.row];
    [_selectArray removeObjectAtIndex:indexPath.row];
    NewsMenuModel *model = [NewsMenuModel MR_createEntity];
    [model setValuesForKeysWithDictionary:d];
    [_currentArray addObject:model];
    [self heightOfHeader];
    [_tableView reloadData];
    
    [[YSLNewsMenuManger shareInstance] addNewsMenuModel:model];
}

- (void) heightOfHeader {
    
    CGFloat height = 40 * HEIGHTSCALE;
    NSInteger count = _currentArray.count / 4;
    if (_currentArray.count % 4 != 0) {
        count += 1;
    }
    
    heightForHeader = height * 2 + height * count;
}

/* 去粘性 */
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = heightForHeader;//设置你footer高度
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
}*/


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_tableView reloadData];

}


- (void) viewWillDisappear:(BOOL)animated {
    
    BOOL flag = false;
    if (_compareArray.count == _currentArray.count) {
        for (int i = 0; i < _compareArray.count; i ++) {
            NewsMenuModel *model1 = _compareArray[i];
            NewsMenuModel *model2 = _currentArray[i];
            if (![model1.channelName isEqualToString:model2.channelName]) {
                flag = true;
            }
        }
    }else {
        
        flag = true;
    }
    
    if (flag) {
        
    NSDictionary *userInfo = @{HYD_NEWSITEM_USERINGO_KEY:_currentArray};
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:HYD_NEWSITEM_CHANGED_FLAG object:nil userInfo:userInfo];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
        
    }
}

@end
