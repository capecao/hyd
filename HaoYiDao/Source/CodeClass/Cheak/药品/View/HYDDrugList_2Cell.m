//
//  HYDDrugList_2Cell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/27.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDDrugList_2Cell.h"

@interface HYDDrugList_2Cell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HYDDrugList_2Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
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
    
    _titleImageView.frame = CGRectMake( 10, 10, (self.bounds.size.height - 20) * 4 / 3,self.bounds.size.height - 20);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_titleImageView.frame) + 10, 5, 200, 15 * HEIGHTSCALE);
    _counterImageView.frame = CGRectMake(CGRectGetMaxX(_titleImageView.frame) + 30,
                                         CGRectGetMaxY(_titleLabel.frame) + 5, 25, 15 * HEIGHTSCALE);
    _typeImageView.frame = CGRectMake(CGRectGetMaxX(_counterImageView.frame) + 5,
                                      CGRectGetMinY(_counterImageView.frame),
                                      CGRectGetWidth(_counterImageView.frame),
                                      CGRectGetHeight(_counterImageView.frame));
    _infolabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),
                                  CGRectGetMaxY(_typeImageView.frame),
                                  self.contentView.frame.size.width - _titleImageView.frame.size.width - 25,
                                  30 * HEIGHTSCALE);
    
    _titleImageView.layer.cornerRadius = ((self.bounds.size.height - 20) * 4 / 3) * .05;
    _titleImageView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:_titleImageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_counterImageView];
    [self.contentView addSubview:_typeImageView];
    [self.contentView addSubview:_infolabel];
    
    
    _infolabel.font = [UIFont systemFontOfSize:12.f];
    _infolabel.numberOfLines = 0;
    
    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5)];
    _line.backgroundColor = HYD_themeColor;
    [self.contentView addSubview:_line];
    
}

- (void)layoutSubviews {
    
    _titleImageView.frame = CGRectMake( 10, 10, (self.bounds.size.height - 20) * 4 / 3,self.bounds.size.height - 20);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_titleImageView.frame) + 10, 5, 200, 15 * HEIGHTSCALE);
    _counterImageView.frame = CGRectMake(CGRectGetMaxX(_titleImageView.frame) + 30,
                                         CGRectGetMaxY(_titleLabel.frame) + 5, 25, 15 * HEIGHTSCALE);
    _typeImageView.frame = CGRectMake(CGRectGetMaxX(_counterImageView.frame) + 5,
                                      CGRectGetMinY(_counterImageView.frame),
                                      CGRectGetWidth(_counterImageView.frame),
                                      CGRectGetHeight(_counterImageView.frame));
    _infolabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),
                                  CGRectGetMaxY(_typeImageView.frame) + 5 * HEIGHTSCALE,
                                  self.contentView.frame.size.width - _titleImageView.frame.size.width - 25,
                                  25 * HEIGHTSCALE);
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);
}




@end
