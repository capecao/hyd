//
//  HYDNearby_briefView.m
//  HYDHelper
//
//  Created by capecao on 16/1/16.
//  Copyright © 2016年 capecao. All rights reserved.
//

#import "HYDNearby_briefView.h"

@implementation HYDNearby_briefView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
        
    }
    
    return self;
}

- (void) setupView {
    
    self.nameLale = [[UILabel alloc]initWithFrame:
                     CGRectMake(0, 0, self.frame.size.width,
                                self.frame.size.height * .3)];
    
    self.imgImageView = [[UIImageView alloc]initWithFrame:
                         CGRectMake(10 * WIDTHTSCALE,
                                    CGRectGetMaxY(_nameLale.frame) + 10 * HEIGHTSCALE,
                                    self.frame.size.height * .4 - 20 * WIDTHTSCALE,
                                    self.frame.size.height * .4 - 15 * HEIGHTSCALE)];
    
    self.introLabel = [[UILabel alloc]initWithFrame:
                       CGRectMake(CGRectGetMaxX(_imgImageView.frame) + 5 * WIDTHTSCALE,
                                  CGRectGetMaxY(_nameLale.frame),
                                  self.frame.size.width -
                                  CGRectGetMaxX(_imgImageView.frame) - 10 * WIDTHTSCALE ,
                                  CGRectGetHeight(_imgImageView.frame) * .6 + 10 * HEIGHTSCALE)];
    
    self.distanceLabel = [[UILabel alloc]initWithFrame:
                          CGRectMake(CGRectGetMinX(_introLabel.frame),
                                     CGRectGetMaxY(_introLabel.frame),
                                     CGRectGetWidth(_introLabel.frame),
                                     CGRectGetHeight(_imgImageView.frame) * .4)];
    
    self.countLabel = [[UILabel alloc]initWithFrame:
                       CGRectMake(0,
                                  CGRectGetMaxY(_imgImageView.frame) + 10 * HEIGHTSCALE,
                                  self.frame.size.width * .2,
                                  self.frame.size.height * .3)];
    
    self.addressLabel = [[UILabel alloc]initWithFrame:
                         CGRectMake(CGRectGetMaxX(_countLabel.frame),
                                    CGRectGetMinY(_countLabel.frame),
                                    self.frame.size.width * .8,
                                    CGRectGetHeight(_countLabel.frame))];
    
    _imgImageView.layer.cornerRadius = 2;
    _imgImageView.layer.borderWidth = 1;
    _imgImageView.layer.borderColor = [UIColor colorwithHexString:@"#98F5FF"].CGColor;
    _imgImageView.layer.masksToBounds = YES;
    
    _nameLale.textAlignment = NSTextAlignmentCenter;
    _nameLale.backgroundColor = HYD_themeColor;
    _nameLale.textColor = [UIColor whiteColor];
    _nameLale.font = HYD_font_MEDIUM(16.f);
    _nameLale.numberOfLines = 0;


    _introLabel.textAlignment = NSTextAlignmentCenter;
    _introLabel.font = HYD_font(14.f);
    _introLabel.textColor = [UIColor colorwithHexString:@"#333333"];
    _introLabel.numberOfLines = 0;
    _introLabel.backgroundColor = [UIColor clearColor];

    _distanceLabel.textAlignment = NSTextAlignmentCenter;
    _distanceLabel.font = HYD_font(12.f);
    _distanceLabel.textColor = HYD_themeColor;
    _distanceLabel.numberOfLines = 0;
    _distanceLabel.backgroundColor = [UIColor clearColor];
    
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.font = HYD_font(12.f);
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.numberOfLines = 0;
    _countLabel.backgroundColor = HYD_themeColor;
    _countLabel.layer.borderWidth = 1;
    _countLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _countLabel.layer.masksToBounds = YES;
    
    _addressLabel.textAlignment = NSTextAlignmentCenter;
    _addressLabel.font = HYD_font(12.f);
    _addressLabel.textColor = [UIColor colorwithHexString:@"#333333"];
    _addressLabel.numberOfLines = 0;
    _addressLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];

    [self addSubview:_nameLale];
    [self addSubview:_imgImageView];
    [self addSubview:_introLabel];
    [self addSubview:_addressLabel];
    [self addSubview:_countLabel];
    [self addSubview:_distanceLabel];
    
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorwithHexString:@"#98F5FF"].CGColor;
    self.layer.masksToBounds = YES;
}


@end
