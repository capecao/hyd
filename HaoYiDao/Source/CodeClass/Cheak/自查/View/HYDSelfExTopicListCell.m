//
//  HYDSelfExTopicListCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/30.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSelfExTopicListCell.h"

@implementation HYDSelfExTopicListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self p_setupView];
        self.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)p_setupView
{
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(10, 5, CGRectGetWidth(self.frame) - 50, 25);
    [self.contentView addSubview:_titleLabel];
    
    self.nextImg = [[UIImageView alloc]init];
    _nextImg.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame) + 9, 5, 12, 20);
    _nextImg.image = [UIImage imageNamed:@"next_icon"];
    [self.contentView addSubview:_nextImg];
    
    self.introLabel = [[UILabel alloc] init];
    _introLabel.numberOfLines = 0;
    _introLabel.font = [UIFont systemFontOfSize:12.f];
    _introLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),
                                   CGRectGetMaxY(_titleLabel.frame) + 5,
                                   CGRectGetWidth(self.frame) - 20,
                                   self.frame.size.height - 40);
    [self.contentView addSubview:_introLabel];
    
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = HYD_themeColor.CGColor;
    self.layer.masksToBounds = YES;
}

- (void) layoutSubviews {
    _titleLabel.frame = CGRectMake(10, 5, CGRectGetWidth(self.frame) - 50, 25);
    _nextImg.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame) + 9, 5, 12, 20);
    _introLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame),
                                   CGRectGetMaxY(_titleLabel.frame) + 5,
                                   CGRectGetWidth(self.frame) - 20,
                                   self.frame.size.height - 40);

}


@end
