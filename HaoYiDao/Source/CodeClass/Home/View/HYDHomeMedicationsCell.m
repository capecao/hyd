//
//  HYDHomeMedicationsCell.m
//  HaoYiDao
//
//  Created by capecao on 16/9/7.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeMedicationsCell.h"

@interface HYDHomeMedicationsCell ()

@end

@implementation HYDHomeMedicationsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_setupView];
    }
    return self;
}

- (void) p_setupView {
    
    self.durgLab = [[UILabel alloc]init];
    self.infoLab = [[UILabel alloc]init];
    self.isOnSwitch = [[UISwitch alloc]init];
    
    _durgLab.frame = CGRectMake(10 * WIDTHTSCALE, 5 * HEIGHTSCALE,
                                self.frame.size.width - 70 * WIDTHTSCALE,
                                self.frame.size.height * .5);
    _infoLab.frame = CGRectMake(CGRectGetMinX(_durgLab.frame),
                                CGRectGetMaxY(_durgLab.frame) + 5 * HEIGHTSCALE,
                                CGRectGetWidth(_durgLab.frame),
                                self.frame.size.height * .5 - 15 * HEIGHTSCALE);
    _isOnSwitch.frame = CGRectMake(CGRectGetMaxX(_durgLab.frame),
                                   self.frame.size.height * .5 - 15 * HEIGHTSCALE,
                                   40 * WIDTHTSCALE, 30 * HEIGHTSCALE);
    
    _durgLab.font = HYD_font_MEDIUM(14.f);
    _infoLab.font = HYD_font(13.f);
    
    [self.contentView addSubview:_durgLab];
    [self.contentView addSubview:_infoLab];
    [self.contentView addSubview:_isOnSwitch];
}

- (void)layoutSubviews {
    
    _durgLab.frame = CGRectMake(10 * WIDTHTSCALE, 5 * HEIGHTSCALE,
                                self.frame.size.width - 70 * WIDTHTSCALE,
                                self.frame.size.height * .5);
    _infoLab.frame = CGRectMake(CGRectGetMinX(_durgLab.frame),
                                CGRectGetMaxY(_durgLab.frame) + 5 * HEIGHTSCALE,
                                CGRectGetWidth(_durgLab.frame),
                                self.frame.size.height * .5 - 15 * HEIGHTSCALE);
    _isOnSwitch.frame = CGRectMake(CGRectGetMaxX(_durgLab.frame),
                                   self.frame.size.height * .5 - 15 * HEIGHTSCALE,
                                   40 * WIDTHTSCALE, 30 * HEIGHTSCALE);
}

@end
