//
//  HYDHomeClassifyTipsCell.m
//  HaoYiDao
//
//  Created by capecao on 16/9/13.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeClassifyTipsCell.h"

@interface HYDHomeClassifyTipsCell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HYDHomeClassifyTipsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_setupView];
    }
    return self;
}

- (void) p_setupView {
    
    self.imgView = [[UIImageView alloc]init];
    self.titLab = [[UILabel alloc]init];
    self.markLab = [[UILabel alloc]init];
    self.timeLab = [[UILabel alloc]init];
    self.line = [[UIView alloc]init];

    _imgView.frame = CGRectMake(10 * WIDTHTSCALE,
                                10 * HEIGHTSCALE,
                                (self.frame.size.height - 20 * HEIGHTSCALE) * 4 / 3,
                                self.frame.size.height - 20 * HEIGHTSCALE);
    _titLab.frame = CGRectMake(CGRectGetMaxX(_imgView.frame) + 10 * WIDTHTSCALE,
                               CGRectGetMinY(_imgView.frame),
                               self.frame.size.width - CGRectGetMaxX(_imgView.frame) -
                               20 * WIDTHTSCALE,
                               _imgView.frame.size.height * .65);
    _markLab.frame = CGRectMake(CGRectGetMinX(_titLab.frame),
                                CGRectGetMaxY(_titLab.frame),
                                CGRectGetWidth(_titLab.frame) * .7,
                                _imgView.frame.size.height * .35);
    _timeLab.frame = CGRectMake(CGRectGetMaxX(_markLab.frame),
                               CGRectGetMinY(_markLab.frame),
                               CGRectGetWidth(_titLab.frame) * .3,
                               CGRectGetHeight(_markLab.frame));
    _line.frame = CGRectMake(10 * WIDTHTSCALE, self.frame.size.height - .5,
                             self.frame.size.width - 20 * WIDTHTSCALE, .5);
    
    _line.backgroundColor = [UIColor colorwithHexString:@"#e9e9e9"];
    _titLab.font = HYD_font(14.f);
    _markLab.font = HYD_font(12.f);
    _timeLab.font = HYD_font(12.f);
    _titLab.numberOfLines = 0;

    _timeLab.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_titLab];
    [self.contentView addSubview:_markLab];
    [self.contentView addSubview:_timeLab];
    [self.contentView addSubview:_line];

}

- (void)layoutSubviews {
    
    _imgView.frame = CGRectMake(10 * WIDTHTSCALE,
                                10 * HEIGHTSCALE,
                                (self.frame.size.height - 20 * HEIGHTSCALE) * 4 / 3,
                                self.frame.size.height - 20 * HEIGHTSCALE);
    _titLab.frame = CGRectMake(CGRectGetMaxX(_imgView.frame) + 10 * WIDTHTSCALE,
                               CGRectGetMinY(_imgView.frame),
                               self.frame.size.width - CGRectGetMaxX(_imgView.frame) -
                               20 * WIDTHTSCALE,
                               CGRectGetHeight(_imgView.frame) * .65);
    _markLab.frame = CGRectMake(CGRectGetMinX(_titLab.frame),
                                CGRectGetMaxY(_titLab.frame),
                                CGRectGetWidth(_titLab.frame) * .7,
                                CGRectGetHeight(_imgView.frame) * .35);
    _timeLab.frame = CGRectMake(CGRectGetMaxX(_markLab.frame),
                               CGRectGetMinY(_markLab.frame),
                               CGRectGetWidth(_titLab.frame) * .3,
                               CGRectGetHeight(_markLab.frame));
    _line.frame = CGRectMake(10 * WIDTHTSCALE, self.frame.size.height - .5,
                             self.frame.size.width - 20 * WIDTHTSCALE, .5);
    
}

@end
