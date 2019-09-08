//
//  HYDNewsTopicDetailCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/27.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeTopicDetailCell.h"

@interface HYDHomeTopicDetailCell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HYDHomeTopicDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupView];

    }
    return self;
}

- (void)p_setupView {
    
    self.titleImageView = [[UIImageView alloc]init];
    self.titleLabel = [[UILabel alloc]init];
    
    _titleImageView.frame = CGRectMake(10 * WIDTHTSCALE,
                                       10 * HEIGHTSCALE,
                                       (self.bounds.size.height - 20 * HEIGHTSCALE) * 4 / 3,
                                       self.bounds.size.height - 20  * HEIGHTSCALE);
    
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_titleImageView.frame) + 10 * WIDTHTSCALE,
                                   0,
                                   self.bounds.size.width - CGRectGetMaxX(_titleImageView.frame) - 20 * WIDTHTSCALE,
                                   self.bounds.size.height);
    
    _titleImageView.layer.cornerRadius = _titleImageView.frame.size.height * .1;
    _titleImageView.layer.masksToBounds = YES;
    
    _titleLabel.font = HYD_font(14.f);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_titleImageView];
    
    self.line = [[UIView alloc]init];
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);
    _line.backgroundColor = [UIColor colorwithHexString:@"#e9e9e9"];
    [self.contentView addSubview:_line];
    
}

- (void)layoutSubviews {
    
    _titleImageView.frame = CGRectMake(10 * WIDTHTSCALE,
                                       10 * HEIGHTSCALE,
                                       (self.bounds.size.height - 20 * HEIGHTSCALE) * 4 / 3,
                                       self.bounds.size.height - 20  * HEIGHTSCALE);
    
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_titleImageView.frame) + 10 * WIDTHTSCALE,
                                   0,
                                   self.bounds.size.width - CGRectGetMaxX(_titleImageView.frame) - 20 * WIDTHTSCALE,
                                   self.bounds.size.height);
    
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);

}



@end
