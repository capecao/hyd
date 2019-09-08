//
//  HYDSearchBaseCell.m
//  HaoYiDao
//
//  Created by capecao on 16/9/9.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSearchBaseCell.h"

@interface HYDSearchBaseCell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HYDSearchBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_setupView];
    }
    
    return self;
}

- (void) p_setupView {
    
    self.titleLab = [[UILabel alloc]init];
    self.removeBt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self.line = [[UIView alloc]init];
    
    _titleLab.frame = CGRectMake(10 * WIDTHTSCALE, 0,
                                 self.frame.size.width - 50 * WIDTHTSCALE,
                                 self.frame.size.height);
    _removeBt.frame = CGRectMake(self.frame.size.width - 40 * WIDTHTSCALE, self.frame.size.height * .5 - 10 * HEIGHTSCALE, 20 * HEIGHTSCALE, 20 * HEIGHTSCALE);
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);
    
    _titleLab.font = HYD_font(14.f);
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_removeBt setBackgroundImage:[UIImage imageNamed:@"icon_search_delete_item"] forState:(UIControlStateNormal)];
    
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_removeBt];
    [self.contentView addSubview:_line];

}

- (void)layoutSubviews {
    
    _titleLab.frame = CGRectMake(10 * WIDTHTSCALE, 0,
                                 self.frame.size.width - 50 * WIDTHTSCALE,
                                 self.frame.size.height);
    _removeBt.frame = CGRectMake(self.frame.size.width - 40 * WIDTHTSCALE, self.frame.size.height * .5 - 10 * HEIGHTSCALE, 20 * HEIGHTSCALE, 20 * HEIGHTSCALE);
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);
}


@end
