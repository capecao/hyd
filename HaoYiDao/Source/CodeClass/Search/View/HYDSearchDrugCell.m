//
//  HYDSearchDrugCell.m
//  HaoYiDao
//
//  Created by capecao on 16/9/10.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSearchDrugCell.h"

@interface HYDSearchDrugCell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HYDSearchDrugCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}

- (void)p_setupView {
    
    self.titleImageView = [[UIImageView alloc]init];
    self.counterImageView = [[UIImageView alloc]init];
    self.typeImageView = [[UIImageView alloc]init];
    self.titleLabel = [[UILabel alloc]init];
    self.infolabel = [[UILabel alloc]init];
    
    _titleImageView.frame = CGRectMake( 10 * WIDTHTSCALE, 10 * HEIGHTSCALE,
                                       50 * HEIGHTSCALE,50 * HEIGHTSCALE);
    
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_titleImageView.frame) + 10 * WIDTHTSCALE,10 * HEIGHTSCALE, 200 * WIDTHTSCALE, 15 * HEIGHTSCALE);
    _counterImageView.frame = CGRectMake(CGRectGetMaxX(_titleImageView.frame) + 30 * WIDTHTSCALE,CGRectGetMaxY(_titleLabel.frame) + 5 * HEIGHTSCALE,
                                         25 * WIDTHTSCALE,
                                         15 * HEIGHTSCALE);
    _typeImageView.frame = CGRectMake(CGRectGetMaxX(_counterImageView.frame) + 5 * HEIGHTSCALE,CGRectGetMinY(_counterImageView.frame),
                                      CGRectGetWidth(_counterImageView.frame),
                                      CGRectGetHeight(_counterImageView.frame));
    _infolabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),
                                  CGRectGetMaxY(_typeImageView.frame),
                                  self.contentView.frame.size.width - _titleImageView.frame.size.width - 25 * WIDTHTSCALE,
                                  self.frame.size.height - CGRectGetMaxY(_typeImageView.frame) - 5 * HEIGHTSCALE);
    
    _titleImageView.layer.cornerRadius = _titleImageView.frame.size.height * .1;
    _titleImageView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:_titleImageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_counterImageView];
    [self.contentView addSubview:_typeImageView];
    [self.contentView addSubview:_infolabel];
    
    _titleLabel.font = HYD_font_DONGQING(14.f);
    _infolabel.font = HYD_font(12.f);
    _infolabel.numberOfLines = 0;
    
    self.line = [[UIView alloc]initWithFrame:CGRectMake(10 * WIDTHTSCALE,
                                                        self.frame.size.height - .5,
                                                        self.frame.size.width - 10 * WIDTHTSCALE,
                                                        .5)];
    _line.backgroundColor = [UIColor colorwithHexString:@"#e9e9e9"];
    [self.contentView addSubview:_line];
    
}

- (void)layoutSubviews {
    
    _titleImageView.frame = CGRectMake( 10 * WIDTHTSCALE, 10 * HEIGHTSCALE,
                                       50 * HEIGHTSCALE,50 * HEIGHTSCALE);
    
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_titleImageView.frame) + 10 * WIDTHTSCALE,10 * HEIGHTSCALE, 200 * WIDTHTSCALE, 15 * HEIGHTSCALE);
    _counterImageView.frame = CGRectMake(CGRectGetMaxX(_titleImageView.frame) + 30 * WIDTHTSCALE,CGRectGetMaxY(_titleLabel.frame) + 5 * HEIGHTSCALE,
                                         25 * WIDTHTSCALE,
                                         15 * HEIGHTSCALE);
    _typeImageView.frame = CGRectMake(CGRectGetMaxX(_counterImageView.frame) + 5 * HEIGHTSCALE,CGRectGetMinY(_counterImageView.frame),CGRectGetWidth(_counterImageView.frame),CGRectGetHeight(_counterImageView.frame));
    _infolabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),
                                  CGRectGetMaxY(_typeImageView.frame),
                                  self.contentView.frame.size.width - _titleImageView.frame.size.width - 25 * WIDTHTSCALE,
                                  self.frame.size.height - CGRectGetMaxY(_typeImageView.frame) - 5 * HEIGHTSCALE);
    _line.frame = CGRectMake(10 * WIDTHTSCALE,
                             self.frame.size.height - .5,
                             self.frame.size.width - 10 * WIDTHTSCALE,
                             .5);
    
    
}

@end
