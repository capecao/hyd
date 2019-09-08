//
//  HYDHomePhysicalCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomePhysicalCell.h"

@interface HYDHomePhysicalCell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HYDHomePhysicalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_setupView];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
    
}

- (void) p_setupView {
    
    self.imgView = [[UIImageView alloc]init];
    self.titLab = [[UILabel alloc]init];
    self.infoLab = [[UILabel alloc]init];
    self.numLab = [[UILabel alloc]init];
    
    _imgView.frame = CGRectMake(10 * WIDTHTSCALE, 10 * HEIGHTSCALE, self.frame.size.height - 20 * HEIGHTSCALE,
                                self.frame.size.height - 20 * HEIGHTSCALE);
    _numLab.frame = CGRectMake(self.frame.size.width - 80 * WIDTHTSCALE, CGRectGetMinY(_imgView.frame),
                               70 * WIDTHTSCALE, CGRectGetHeight(_imgView.frame) * .4);
    _titLab.frame = CGRectMake(CGRectGetMaxX(_imgView.frame) + 10 * WIDTHTSCALE, 5 * HEIGHTSCALE,
                               self.frame.size.width - 100 * WIDTHTSCALE - self.frame.size.height + 20 * HEIGHTSCALE,
                               CGRectGetHeight(_numLab.frame));
    _infoLab.frame = CGRectMake(CGRectGetMinX(_titLab.frame), CGRectGetMaxY(_titLab.frame),
                                self.frame.size.width - self.frame.size.height + 20 * HEIGHTSCALE - 30 * WIDTHTSCALE,
                                CGRectGetHeight(_imgView.frame) * .6);
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_numLab];
    [self.contentView addSubview:_titLab];
    [self.contentView addSubview:_infoLab];

    _imgView.layer.cornerRadius = _imgView.frame.size.height * .05;
    _imgView.layer.masksToBounds = YES;
    
    _numLab.textColor = [UIColor colorwithHexString:@"#4f4f4f"];
    _numLab.font = HYD_font(10.f);
    
    _titLab.textColor = [UIColor colorwithHexString:@"#414141"];
    _titLab.font = HYD_font_DONGQING(12.f);
    
    _infoLab.textColor = [UIColor colorwithHexString:@"#4f4f4f"];
    _infoLab.font = HYD_font(10.f);
    _infoLab.numberOfLines = 2;
    
    self.line = [[UIView alloc]init];
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);
    _line.backgroundColor = HYD_themeColor;
    [self.contentView addSubview:_line];
    
}

-(void)layoutSubviews {
    
    _imgView.frame = CGRectMake(10 * WIDTHTSCALE, 10 * HEIGHTSCALE, self.frame.size.height - 20 * HEIGHTSCALE,
                                self.frame.size.height - 20 * HEIGHTSCALE);
    _numLab.frame = CGRectMake(self.frame.size.width - 80 * WIDTHTSCALE, CGRectGetMinY(_imgView.frame),
                               70 * WIDTHTSCALE, CGRectGetHeight(_imgView.frame) * .4);
    _titLab.frame = CGRectMake(CGRectGetMaxX(_imgView.frame) + 10 * WIDTHTSCALE, 5 * HEIGHTSCALE,
                               self.frame.size.width - 100 * WIDTHTSCALE - self.frame.size.height + 20 * HEIGHTSCALE,
                               CGRectGetHeight(_numLab.frame));
    _infoLab.frame = CGRectMake(CGRectGetMinX(_titLab.frame), CGRectGetMaxY(_titLab.frame),
                                self.frame.size.width - self.frame.size.height + 20 * HEIGHTSCALE - 30 * WIDTHTSCALE,
                                CGRectGetHeight(_imgView.frame) * .6);
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);

}


@end
