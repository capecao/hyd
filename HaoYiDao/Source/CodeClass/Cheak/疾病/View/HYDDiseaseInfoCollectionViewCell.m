//
//  HYDSelfExDrugCollectionViewCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/31.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDDiseaseInfoCollectionViewCell.h"

@implementation HYDDiseaseInfoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView {
    
    self.titleImageView = [[UIImageView alloc]init];
    self.nameLabel = [[UILabel alloc]init];
    
    _titleImageView.frame = CGRectMake(10 * WIDTHTSCALE, 5 * HEIGHTSCALE,
                                       self.bounds.size.width - 20 * WIDTHTSCALE,
                                       self.bounds.size.height * .7 - 15 * HEIGHTSCALE );
    _nameLabel.frame = CGRectMake(0,
                                  CGRectGetMaxY(_titleImageView.frame) + 5 * HEIGHTSCALE,
                                  self.contentView.frame.size.width,
                                  self.bounds.size.height * .3);
    
    _titleImageView.layer.cornerRadius = _titleImageView.frame.size.height * .1;
    _titleImageView.layer.masksToBounds = YES;
    
    _nameLabel.font = HYD_font_MEDIUM(13.f);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_titleImageView];
}

-(void)layoutSubviews {
    
    _titleImageView.frame = CGRectMake(10 * WIDTHTSCALE, 5 * HEIGHTSCALE,
                                       self.bounds.size.width - 20 * WIDTHTSCALE,
                                       self.bounds.size.height * .7 - 15 * HEIGHTSCALE );
    _nameLabel.frame = CGRectMake(0,
                                  CGRectGetMaxY(_titleImageView.frame) + 5 * HEIGHTSCALE,
                                  self.contentView.frame.size.width,
                                  self.bounds.size.height * .3);
}

@end
