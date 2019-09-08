//
//  HYDDiseaseInfoCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/31.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDDiseaseInfoCell.h"

@implementation HYDDiseaseInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_setupView];
        
    }
    
    return self;
}

- (void)p_setupView {
    
    self.picImageView = [[UIImageView alloc]init];
    self.titleLabel = [[UILabel alloc]init];
    self.infolabel = [[UILabel alloc]init];
    
    _picImageView.frame = CGRectMake(10 * WIDTHTSCALE,
                                     10 * HEIGHTSCALE,
                                     self.bounds.size.height,
                                     self.bounds.size.height - 20 * HEIGHTSCALE);
    
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_picImageView.frame) + 10  * WIDTHTSCALE,
                                   CGRectGetMinY(_picImageView.frame),
                                   self.bounds.size.width - CGRectGetMaxX(_picImageView.frame) - 20 * WIDTHTSCALE,
                                   _picImageView.frame.size.height * .4);
    
    _infolabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),
                                  CGRectGetMaxY(_titleLabel.frame),
                                  CGRectGetWidth(_titleLabel.frame),
                                  _picImageView.frame.size.height * .6);
    
    _picImageView.layer.cornerRadius = _picImageView.frame.size.height * .1;
    _picImageView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:_picImageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_infolabel];
    
    _titleLabel.font = HYD_font_MEDIUM(14.f);
    _infolabel.font = HYD_font(12.f);
    _infolabel.numberOfLines = 0;
}

- (void)layoutSubviews {
    
    _picImageView.frame = CGRectMake(10 * WIDTHTSCALE,
                                     10 * HEIGHTSCALE,
                                     self.bounds.size.height,
                                     self.bounds.size.height - 20 * HEIGHTSCALE);
    
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_picImageView.frame) + 10  * WIDTHTSCALE,
                                   CGRectGetMinY(_picImageView.frame),
                                   self.bounds.size.width - CGRectGetMaxX(_picImageView.frame) - 20 * WIDTHTSCALE,
                                   _picImageView.frame.size.height * .4);
    
    _infolabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),
                                  CGRectGetMaxY(_titleLabel.frame),
                                  CGRectGetWidth(_titleLabel.frame),
                                  _picImageView.frame.size.height * .6);
}

@end
