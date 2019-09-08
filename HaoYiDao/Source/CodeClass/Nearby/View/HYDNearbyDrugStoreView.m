//
//  HYDNearbyDrugStoreView.m
//  HaoYiDao
//
//  Created by Sprixin on 16/6/2.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNearbyDrugStoreView.h"

@implementation HYDNearbyDrugStoreView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self p_setupView];
    }
    
    return self;
}

- (void) p_setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    CGFloat tempHeight = self.bounds.size.height * .65 + 80  * HEIGHTSCALE + self.bounds.size.width * .33;
    _scrollView.contentSize = CGSizeMake(0,0);
    _scrollView.backgroundColor = [UIColor whiteColor];
    if (tempHeight > self.bounds.size.height)
        _scrollView.contentSize = CGSizeMake(0, tempHeight);
    
    [self addSubview:_scrollView];
    
    self.mapView = [[MAMapView alloc]initWithFrame:
                    CGRectMake(0, 0, self.frame.size.width,
                               self.bounds.size.height * .5 - 64)];
    _mapView.showsUserLocation = YES;
    
    self.nameLabel = [[UILabel alloc]initWithFrame:
                      CGRectMake(0, CGRectGetMaxY(_mapView.frame),
                                 self.bounds.size.width,
                                 self.bounds.size.height * .075)];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:
                          CGRectMake(10,
                                     CGRectGetMaxY(_nameLabel.frame) + 10 * HEIGHTSCALE,
                                     self.bounds.size.width * .33,
                                     self.bounds.size.width * .33)];
    
    self.businessLabel = [[UILabel alloc]initWithFrame:
                          CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 5 * HEIGHTSCALE,
                                     CGRectGetMinY(_iconImageView.frame),
                                     self.bounds.size.width  -
                                     CGRectGetMaxX(_iconImageView.frame) - 10 * WIDTHTSCALE,
                                     CGRectGetHeight(_iconImageView.frame))];
    
    self.addressLabel = [[UILabel alloc]initWithFrame:
                         CGRectMake(5,
                                    CGRectGetMaxY(_iconImageView.frame) + 10 * HEIGHTSCALE,
                                    self.bounds.size.width - 10 * WIDTHTSCALE,
                                    self.bounds.size.height * .075)];
    
    self.telButton  = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _telButton.frame = CGRectMake(self.bounds.size.width / 5,
                                  CGRectGetMaxY(_addressLabel.frame) + 20 * HEIGHTSCALE,
                                  self.bounds.size.width * .6,
                                  40 * HEIGHTSCALE);
    
    
    [_telButton setTintColor:[UIColor whiteColor]];
    _telButton.layer.cornerRadius = 5;
    _telButton.layer.masksToBounds = YES;
    
    _nameLabel.font = HYD_font_MEDIUM(15.f);
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.backgroundColor = HYD_themeColor;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    
    _addressLabel.numberOfLines = 0;
    _addressLabel.font = HYD_font(14.f);
    _addressLabel.textAlignment = NSTextAlignmentCenter;
    
    _iconImageView.layer.cornerRadius = 5;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.borderColor = HYD_themeColor.CGColor;
    _iconImageView.layer.borderWidth = .5;
    
    _telButton.backgroundColor = HYD_themeColor;
    
    _businessLabel.numberOfLines = 0;
    _businessLabel.font = HYD_font(14.f);
    _businessLabel.textAlignment = NSTextAlignmentCenter;
    
    [_scrollView addSubview:_mapView];
    [_scrollView addSubview:_nameLabel];
    [_scrollView addSubview:_addressLabel];
    [_scrollView addSubview:_iconImageView];
    [_scrollView addSubview:_telButton];
    [_scrollView addSubview:_businessLabel];
    
}


@end
