//
//  HYDHomeItemView.m
//  HaoYiDao
//
//  Created by capecao on 16/9/3.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeThemeView.h"

@implementation HYDHomeThemeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupView];
    }
    return self;
}

- (void) p_setupView {
    
    
    self.button0 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self.button1 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self.button2 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];

    CGFloat width = self.frame.size.width / 3 - 20 * WIDTHTSCALE;
    
    _button0.frame = CGRectMake(20 * WIDTHTSCALE, 15 * HEIGHTSCALE, width, 44);
    _button1.frame = CGRectMake(CGRectGetMaxX(_button0.frame) + 10 * WIDTHTSCALE, CGRectGetMinY(_button0.frame), CGRectGetWidth(_button0.frame), CGRectGetHeight(_button0.frame));
    _button2.frame = CGRectMake(CGRectGetMaxX(_button1.frame) + 10 * WIDTHTSCALE, CGRectGetMinY(_button0.frame), CGRectGetWidth(_button0.frame), CGRectGetHeight(_button0.frame));

    [self addSubview:_button0];
    [self addSubview:_button1];
    [self addSubview:_button2];
    
    [self p_setupButtonFeatures:_button0 :[UIColor colorwithHexString:@"#FF758C"]];
    [self p_setupButtonFeatures:_button1 :[UIColor colorwithHexString:@"#f6e700"]];
    [self p_setupButtonFeatures:_button2 :[UIColor colorwithHexString:@"#2cf4a6"]];

    
    self.scrollView = [[UIScrollView alloc]initWithFrame:
                       CGRectMake(0, CGRectGetMaxY(_button0.frame) + 15 * HEIGHTSCALE,
                                  self.frame.size.width,
                                  self.frame.size.height - CGRectGetMaxY(_button0.frame) -
                                  15 * HEIGHTSCALE)];
    [self addSubview:_scrollView];
    
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, 0);
    
    CGFloat width1 = _scrollView.frame.size.width;
    CGFloat height1 = _scrollView.frame.size.height;
    
    self.tableView0 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width1, height1) style:(UITableViewStylePlain)];
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(width1, 0, width1, height1) style:(UITableViewStylePlain)];
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(width1 * 2, 0, width1, height1) style:(UITableViewStylePlain)];
    
    [_scrollView addSubview:_tableView0];
    [_scrollView addSubview:_tableView1];
    [_scrollView addSubview:_tableView2];

    [self p_setupTableViewFeatures:_tableView0];
    [self p_setupTableViewFeatures:_tableView1];
    [self p_setupTableViewFeatures:_tableView2];

}

- (void) p_setupButtonFeatures:(UIButton *)button :(UIColor *)color{
    
    button.backgroundColor = color;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = button.frame.size.height * .1;
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = HYD_font_DONGQING(14.f);
    [button setTitle:@"好医道" forState:(UIControlStateNormal)];
}

- (void) p_setupTableViewFeatures:(UITableView *)tableView {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

@end
