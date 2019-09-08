//
//  HYDNearbyListCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/6/2.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNearbyListCell.h"

@interface HYDNearbyListCell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HYDNearbyListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_setupView];
    }
    return self;
}


- (void)p_setupView {
    
    self.nameLale = [[UILabel alloc]init];
    self.introLabel = [[UILabel alloc]init];
    self.imgImageView = [[UIImageView alloc]init];
    self.distanceLabel = [[UILabel alloc]init];

    _imgImageView.frame = CGRectMake(10 * WIDTHTSCALE,
                                     10 * HEIGHTSCALE,
                                     self.bounds.size.height,
                                     self.bounds.size.height - 20 * WIDTHTSCALE);
    _nameLale.frame = CGRectMake(CGRectGetMaxX(_imgImageView.frame) + 10 * WIDTHTSCALE,
                                 CGRectGetMinY(_imgImageView.frame) - 5 * HEIGHTSCALE,
                                 self.contentView.frame.size.width -
                                 CGRectGetMaxX(_imgImageView.frame) - 15 * WIDTHTSCALE,
                                 CGRectGetHeight(_imgImageView.frame) * .3 + 5 * HEIGHTSCALE);
    _introLabel.frame = CGRectMake(CGRectGetMinX(_nameLale.frame),
                                   CGRectGetMaxY(_nameLale.frame),
                                   CGRectGetWidth(_nameLale.frame),
                                   CGRectGetHeight(_imgImageView.frame) * .5);
    _distanceLabel.frame = CGRectMake(self.frame.size.width - 80 * WIDTHTSCALE,
                                      CGRectGetMaxY(_introLabel.frame),
                                      70 * WIDTHTSCALE,
                                      self.frame.size.height - CGRectGetMaxY(_introLabel.frame));
    
    [self.contentView addSubview:_nameLale];
    [self.contentView addSubview:_imgImageView];
    [self.contentView addSubview:_introLabel];
    [self.contentView addSubview:_distanceLabel];

    _nameLale.font = HYD_font(15.f);
    _introLabel.font = HYD_font(12.f);
    _distanceLabel.font = HYD_font(11.f);
    
    _distanceLabel.textAlignment = NSTextAlignmentRight;
    
    _imgImageView.layer.cornerRadius = (self.bounds.size.height - 15) * .05;
    _imgImageView.layer.masksToBounds = YES;
    
    self.line = [[UIView alloc]init];
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);
    _line.backgroundColor = [UIColor colorwithHexString:@"#e9e9e9"];
    [self.contentView addSubview:_line];

}

- (void)layoutSubviews {
    
    _imgImageView.frame = CGRectMake(10 * WIDTHTSCALE,
                                     10 * HEIGHTSCALE,
                                     self.bounds.size.height,
                                     self.bounds.size.height - 20 * WIDTHTSCALE);
    _nameLale.frame = CGRectMake(CGRectGetMaxX(_imgImageView.frame) + 10 * WIDTHTSCALE,
                                 CGRectGetMinY(_imgImageView.frame) - 5 * HEIGHTSCALE,
                                 self.contentView.frame.size.width -
                                 CGRectGetMaxX(_imgImageView.frame) - 15 * WIDTHTSCALE,
                                 CGRectGetHeight(_imgImageView.frame) * .3 + 5 * HEIGHTSCALE);
    _introLabel.frame = CGRectMake(CGRectGetMinX(_nameLale.frame),
                                   CGRectGetMaxY(_nameLale.frame),
                                   CGRectGetWidth(_nameLale.frame),
                                   CGRectGetHeight(_imgImageView.frame) * .5);
    _distanceLabel.frame = CGRectMake(self.frame.size.width - 100 * WIDTHTSCALE,
                                      CGRectGetMaxY(_introLabel.frame),
                                      90 * WIDTHTSCALE,
                                      self.frame.size.height - CGRectGetMaxY(_introLabel.frame));
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);

}

@end
