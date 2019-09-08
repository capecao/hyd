//
//  HYDHealthClassifyCell.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/25.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "HYDHealthClassifyCell.h"

@implementation HYDHealthClassifyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_setupViews];
    }
    
    return self;
}

- (void) p_setupViews {
    
    self.titleLab = [[UILabel alloc]init];
    self.img = [[UIImageView alloc]init];
    UIView *line = [[UIView alloc]init];

    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_img];
    [self.contentView addSubview:line];

    line.backgroundColor = HYD_themeColor;
    _img.image = [UIImage imageNamed:@"next_icon"];
    _titleLab.font = HYD_font_MEDIUM(16.f);
    
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15 * WIDTHTSCALE);
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(_img.mas_left);
    }];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-15 * WIDTHTSCALE);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(10, 18));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.contentView);
        make.height.equalTo(@(.5 * HEIGHTSCALE));
    }];

}

@end
