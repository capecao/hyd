//
//  HYDHomeClassifyView.m
//  HaoYiDao
//
//  Created by capecao on 16/9/3.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeClassifyView.h"

@implementation HYDHomeClassifyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self p_setupView];
    }
    return self;
}

- (void) p_setupView {
    
    CGFloat width0 = self.frame.size.width * .42 - .5;
    CGFloat width1 = self.frame.size.width * .58 - .5;
    CGFloat height = self.frame.size.height;

    self.tableView0 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width0, height)
                                                  style:(UITableViewStylePlain)];
    _tableView0.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView0.showsVerticalScrollIndicator = NO;
    _tableView0.backgroundColor = [UIColor whiteColor];
    
    self.tableView1 = [[UITableView alloc]initWithFrame:
                       CGRectMake(CGRectGetMaxX(_tableView0.frame) + 2,0, width1, height)
                                                  style:(UITableViewStylePlain)];
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView1.showsVerticalScrollIndicator = NO;
    _tableView1.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(width0 + .5, 0, 1, height)];
    line.backgroundColor = HYD_themeColor;
    [self addSubview:line];
    
    [self addSubview:_tableView0];
    [self addSubview:_tableView1];
}


@end
