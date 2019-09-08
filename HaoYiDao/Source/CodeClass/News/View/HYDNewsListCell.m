//
//  HYDNewsListCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNewsListCell.h"

@implementation HYDNewsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)p_setupView {
    
    self.titleLabel = [[UILabel alloc]init];
    self.introductionLabel = [[UILabel alloc]init];
    self.iconImageView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_iconImageView];
    [self.contentView addSubview:_introductionLabel];
    
    _introductionLabel.numberOfLines = 0;
    
    _titleLabel.font = HYD_font_MEDIUM(14.f);
    _introductionLabel.font = HYD_font(12.f);
    
    _iconImageView.layer.cornerRadius = 5;
    _iconImageView.layer.masksToBounds = YES;
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(5 * WIDTHTSCALE);
        make.top.equalTo(self.contentView).with.offset(5 * HEIGHTSCALE);
        make.bottom.equalTo(self.contentView).with.offset(-5 * HEIGHTSCALE);
        make.width.equalTo(_iconImageView.mas_height);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).with.offset(5 * WIDTHTSCALE);
        make.top.equalTo(_iconImageView);
        make.bottom.equalTo(_introductionLabel.mas_top);
        make.right.equalTo(self.contentView).with.offset(-5 * WIDTHTSCALE);
    }];
    
    [_introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom);
        make.bottom.equalTo(self.contentView).with.offset(-5 * WIDTHTSCALE);
    }];
    
}

@end
