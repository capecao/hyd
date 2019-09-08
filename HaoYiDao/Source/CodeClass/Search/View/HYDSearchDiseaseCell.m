//
//  HYDSearchDeseaseCell.m
//  HaoYiDao
//
//  Created by capecao on 16/9/10.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSearchDiseaseCell.h"

@interface HYDSearchDiseaseCell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HYDSearchDiseaseCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}

- (void)p_setupView {

    self.titLab = [[UILabel alloc]init];
    self.infoLab = [[UILabel alloc]init];
    self.line = [[UIView alloc]init];

    _titLab.frame = CGRectMake(10 * WIDTHTSCALE,
                               5 * HEIGHTSCALE,
                               self.frame.size.width - 20 * WIDTHTSCALE,
                               self.frame.size.height * .5 - 5 * HEIGHTSCALE);
    _infoLab.frame = CGRectMake(10 * WIDTHTSCALE,
                               CGRectGetMaxY(_titLab.frame),
                               CGRectGetWidth(_titLab.frame),
                                CGRectGetHeight(_titLab.frame));
    _line.frame = CGRectMake(10 * WIDTHTSCALE,
                             self.frame.size.height - .5,
                             self.frame.size.width - 10 * WIDTHTSCALE,
                             .5);

    _line.backgroundColor = [UIColor colorwithHexString:@"#e9e9e9"];
    _titLab.font = HYD_font_DONGQING(14.f);
    _infoLab.font = HYD_font(12.f);
    _infoLab.numberOfLines = 0;
    
    [self.contentView addSubview:_titLab];
    [self.contentView addSubview:_infoLab];
    [self.contentView addSubview:_line];
    
}

- (void)layoutSubviews {
    
    _titLab.frame = CGRectMake(10 * WIDTHTSCALE,
                               5 * HEIGHTSCALE,
                               self.frame.size.width - 20 * WIDTHTSCALE,
                               self.frame.size.height * .5 - 5 * HEIGHTSCALE);
    _infoLab.frame = CGRectMake(10 * WIDTHTSCALE,
                                CGRectGetMaxY(_titLab.frame),
                                CGRectGetWidth(_titLab.frame),
                                CGRectGetHeight(_titLab.frame));
    _line.frame = CGRectMake(10 * WIDTHTSCALE,
                             self.frame.size.height - .5,
                             self.frame.size.width - 10 * WIDTHTSCALE,
                             .5);

}

@end
