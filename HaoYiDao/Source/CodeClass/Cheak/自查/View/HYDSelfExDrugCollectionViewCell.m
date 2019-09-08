//
//  HYDSelfExDrugCollectionViewCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/31.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSelfExDrugCollectionViewCell.h"

@implementation HYDSelfExDrugCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView {
    
    self.titleImageView = [[UIImageView alloc]init];
    self.titleLabel = [[UILabel alloc]init];
    
    _titleImageView.frame = CGRectMake(10,
                                       5,
                                       self.bounds.size.width - 20,
                                       self.bounds.size.height * .7 - 15 );
    
    _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleImageView.frame) + 5,
                                   self.contentView.frame.size.width,
                                   self.bounds.size.height * .3);
    
    _titleImageView.layer.cornerRadius = ((self.contentView.frame.size.height - 10 )* 5 / 6) * .05;
    _titleImageView.layer.masksToBounds = YES;
    
    _titleLabel.font = [UIFont systemFontOfSize:13.f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_titleImageView];
}

-(void)layoutSubviews {
    
    _titleImageView.frame = CGRectMake(10,
                                       5,
                                       self.bounds.size.width - 20,
                                       (self.bounds.size.height - 10 )* 5 / 6);
    
    _titleLabel.frame = CGRectMake(0,
                                   CGRectGetMaxY(_titleImageView.frame),
                                   self.contentView.frame.size.width,
                                   (self.contentView.frame.size.height - 10 ) / 6);
    
}

@end
