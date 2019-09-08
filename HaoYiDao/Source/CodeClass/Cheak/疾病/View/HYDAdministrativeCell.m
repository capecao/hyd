//
//  HYDAdministrativeCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/31.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDAdministrativeCell.h"

@implementation HYDAdministrativeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_setupView];
        self.backgroundColor = HYD_themeColor;
        self.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void) p_setupView {
    
    self.titImageView = [[UIImageView alloc]init];
    self.nameLabel = [[UILabel alloc]init];
    
    _titImageView.frame = CGRectMake(10 * WIDTHTSCALE, 10 * HEIGHTSCALE,
                                     self.bounds.size.height - 20 * HEIGHTSCALE,
                                     self.bounds.size.height - 20 * HEIGHTSCALE);
    
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_titImageView.frame) + 10 * WIDTHTSCALE,
                                  0,
                                  self.bounds.size.width - CGRectGetMaxX(_titImageView.frame) - 15 * WIDTHTSCALE,
                                  self.bounds.size.height);
    
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = HYD_font_MEDIUM(14.F);
    
    [self.contentView addSubview:_titImageView];
    [self.contentView addSubview:_nameLabel];
    
    self.layer.cornerRadius = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
    
}

- (void)layoutSubviews {
    
    _titImageView.frame = CGRectMake(10 * WIDTHTSCALE, 10 * HEIGHTSCALE,
                                     self.bounds.size.height - 20 * HEIGHTSCALE,
                                     self.bounds.size.height - 20 * HEIGHTSCALE);
    
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_titImageView.frame) + 10 * WIDTHTSCALE,
                                  0,
                                  self.bounds.size.width - CGRectGetMaxX(_titImageView.frame) - 15 * WIDTHTSCALE,
                                  self.bounds.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    CGRect frame = self.bounds;
    [UIView animateWithDuration:0.3 animations:^{
        self.bounds = CGRectMake(-10, -15, frame.size.width + 10, frame.size.height + 30);
    }];
    self.bounds = frame;
}



@end
