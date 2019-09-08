//
//  HYDSearchChannelCell.m
//  HaoYiDao
//
//  Created by capecao on 16/9/10.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSearchChannelCell.h"

@interface HYDSearchChannelCell ()

@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *bgView;

@end

@implementation HYDSearchChannelCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}

- (void)p_setupView {

    self.imgView = [[UIImageView alloc]init];
    self.titLab = [[UILabel alloc]init];
    self.infoLab = [[UILabel alloc]init];
    self.likeLab = [[UILabel alloc]init];
    self.bgView = [[UIView alloc]init];
    self.line = [[UIView alloc]init];

    _bgView.frame = CGRectMake(10 * WIDTHTSCALE, 10 * HEIGHTSCALE,
                               self.frame.size.height - 35 * HEIGHTSCALE,
                               self.frame.size.height - 35 * HEIGHTSCALE);
    _imgView.frame = CGRectMake(CGRectGetMinX(_bgView.frame),
                                CGRectGetMinY(_bgView.frame) + _bgView.frame.size.height * .25,
                                CGRectGetWidth(_bgView.frame),
                                CGRectGetHeight(_bgView.frame) * .5);
    _titLab.frame = CGRectMake(CGRectGetMaxX(_bgView.frame) + 10 *WIDTHTSCALE,
                               CGRectGetMinY(_bgView.frame),
                               self.frame.size.width - CGRectGetMaxX(_bgView.frame) - 20 * WIDTHTSCALE,
                               _bgView.frame.size.height * .4);
    _infoLab.frame = CGRectMake(CGRectGetMinX(_titLab.frame),
                               CGRectGetMaxY(_titLab.frame),
                               CGRectGetWidth(_titLab.frame),
                               _bgView.frame.size.height * .6);
    _likeLab.frame = CGRectMake(self.frame.size.width - 200 * WIDTHTSCALE, CGRectGetMaxY(_bgView.frame), 180 * WIDTHTSCALE, 20 * HEIGHTSCALE);
    _line.frame = CGRectMake(10 * WIDTHTSCALE,
                             self.frame.size.height - .5,
                             self.frame.size.width - 10 * WIDTHTSCALE,
                             .5);
    
    _line.backgroundColor = [UIColor colorwithHexString:@"#e9e9e9"];
    _titLab.font = HYD_font_DONGQING(14.f);
    _infoLab.font = HYD_font(12.f);
    _infoLab.numberOfLines = 0;
    _likeLab.font = HYD_font(11.f);
    _likeLab.textAlignment = NSTextAlignmentRight;

    _bgView.layer.masksToBounds = YES;
    _bgView.layer.borderWidth = .5;
    _bgView.layer.borderColor = HYD_themeColor.CGColor;
    
    [self.contentView addSubview:_bgView];
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_titLab];
    [self.contentView addSubview:_infoLab];
    [self.contentView addSubview:_likeLab];
    [self.contentView addSubview:_line];

}

- (void)layoutSubviews {
    
    _bgView.frame = CGRectMake(10 * WIDTHTSCALE, 10 * HEIGHTSCALE,
                               self.frame.size.height - 35 * HEIGHTSCALE,
                               self.frame.size.height - 35 * HEIGHTSCALE);
    _imgView.frame = CGRectMake(CGRectGetMinX(_bgView.frame),
                                CGRectGetMinY(_bgView.frame) + _bgView.frame.size.height * .25,
                                CGRectGetWidth(_bgView.frame),
                                CGRectGetHeight(_bgView.frame) * .5);
    _titLab.frame = CGRectMake(CGRectGetMaxX(_bgView.frame) + 10 *WIDTHTSCALE,
                               CGRectGetMinY(_bgView.frame),
                               self.frame.size.width - CGRectGetMaxX(_bgView.frame) - 20 * WIDTHTSCALE,
                               _bgView.frame.size.height * .4);
    _infoLab.frame = CGRectMake(CGRectGetMinX(_titLab.frame),
                                CGRectGetMaxY(_titLab.frame),
                                CGRectGetWidth(_titLab.frame),
                                _bgView.frame.size.height * .6);
    _likeLab.frame = CGRectMake(self.frame.size.width - 200 * WIDTHTSCALE, CGRectGetMaxY(_bgView.frame), 180 * WIDTHTSCALE, 20 * HEIGHTSCALE);
    _line.frame = CGRectMake(10 * WIDTHTSCALE,
                             self.frame.size.height - .5,
                             self.frame.size.width - 10 * WIDTHTSCALE,
                             .5);

}


@end
