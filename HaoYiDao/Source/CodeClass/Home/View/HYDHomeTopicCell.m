//
//  HYDNewsTopicCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/27.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeTopicCell.h"

@implementation HYDHomeTopicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView {
    
    self.titleImageView = [[UIImageView alloc]init];
    self.titleLabel = [[UILabel alloc]init];

    _titleImageView.layer.cornerRadius = _titleImageView.frame.size.height * .1;
    _titleImageView.layer.masksToBounds = YES;
    
    _titleLabel.font = [UIFont systemFontOfSize:20.f];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = HYD_themeColor;
    _titleLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_titleImageView];
    [self.contentView addSubview:_titleLabel];
    
    
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(10 * HEIGHTSCALE);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(_titleImageView);
        make.left.equalTo(_titleImageView).with.offset(15 * WIDTHTSCALE);
        make.height.equalTo(@(45 * HEIGHTSCALE));
    }];


}

@end
