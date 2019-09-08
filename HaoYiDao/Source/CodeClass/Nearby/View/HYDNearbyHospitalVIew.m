//
//  HYDNearbyHospitalVIew.m
//  HaoYiDao
//
//  Created by Sprixin on 16/6/2.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNearbyHospitalVIew.h"

@implementation HYDNearbyHospitalVIew

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self p_setupView];
    }
    
    return self;
}

- (void) p_setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    CGFloat tempHeight = self.bounds.size.height + self.bounds.size.width * .7 + 62;
    _scrollView.contentSize = CGSizeMake(0, tempHeight);
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];
    
    self.mapView = [[MAMapView alloc]initWithFrame:
                    CGRectMake(0, 0, self.bounds.size.width,
                               self.bounds.size.height / 2 - 64)];
    
    _mapView.showsUserLocation = YES;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:
                          CGRectMake(10 * WIDTHTSCALE,
                                     CGRectGetMaxY(_mapView.frame) + 10 * HEIGHTSCALE,
                                     self.bounds.size.width / 2 - 20 * WIDTHTSCALE,
                                     self.bounds.size.width / 2 - 20 * WIDTHTSCALE)];
    _iconImageView.backgroundColor = [UIColor whiteColor];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:
                      CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 10 * WIDTHTSCALE,
                                 CGRectGetMinY(_iconImageView.frame),
                                 CGRectGetWidth(_iconImageView.frame) + 10 * WIDTHTSCALE,
                                 CGRectGetHeight(_iconImageView.frame) * .4)];
    
    self.levelLabel = [[UILabel alloc]initWithFrame:
                       CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 5 * WIDTHTSCALE,
                                  CGRectGetMaxY(_nameLabel.frame),
                                  CGRectGetWidth(_nameLabel.frame) / 2,
                                  CGRectGetHeight(_iconImageView.frame) * .2)];
    
    self.typeLabel = [[UILabel alloc]initWithFrame:
                      CGRectMake(CGRectGetMaxX(_levelLabel.frame) + 10 * WIDTHTSCALE,
                                 CGRectGetMinY(_levelLabel.frame),
                                 CGRectGetWidth(_levelLabel.frame),
                                 CGRectGetHeight(_levelLabel.frame))];
    
    self.addressLabel = [[UILabel alloc]initWithFrame:
                         CGRectMake(CGRectGetMinX(_nameLabel.frame),
                                    CGRectGetMaxY(_levelLabel.frame),
                                    CGRectGetWidth(_nameLabel.frame),
                                    CGRectGetHeight(_nameLabel.frame))];
    
    UILabel *introduceLabel = [[UILabel alloc]initWithFrame:
                               CGRectMake(10 * WIDTHTSCALE,
                                          CGRectGetMaxY(_iconImageView.frame) + 10 * HEIGHTSCALE,
                                          self.bounds.size.width / 2, 40 * HEIGHTSCALE)];
    
    self.messageView = [[UIWebView alloc]initWithFrame:
                        CGRectMake(5 * WIDTHTSCALE,
                                   CGRectGetMaxY(introduceLabel.frame),
                                   self.bounds.size.width - 10 * WIDTHTSCALE,
                                   self.bounds.size.height / 2)];
    
    self.telButton  = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _telButton.frame = CGRectMake(self.bounds.size.width / 5,
                                  CGRectGetMaxY(_messageView.frame) + 20 * HEIGHTSCALE,
                                  self.bounds.size.width * .6,
                                  CGRectGetHeight(_levelLabel.frame));
    
    self.label = [[UILabel alloc]initWithFrame:
                  CGRectMake(CGRectGetMinX(introduceLabel.frame),
                             CGRectGetMaxY(_telButton.frame) + 20 * HEIGHTSCALE,
                             CGRectGetWidth(introduceLabel.frame),
                             CGRectGetHeight(introduceLabel.frame))];
    _label.text = @"特色科室";
    _label.font = HYD_font(14.f);
    
    [_telButton setTintColor:[UIColor whiteColor]];
    _telButton.layer.cornerRadius = 5;
    _telButton.layer.masksToBounds = YES;
    
    introduceLabel.text = @"简介";
    introduceLabel.font = HYD_font(14.f);
    
    _nameLabel.font = HYD_font_MEDIUM(15.f);
    _nameLabel.textColor = HYD_themeColor;
    
    _levelLabel.layer.cornerRadius = 5;
    _levelLabel.layer.masksToBounds = YES;
    _levelLabel.layer.borderColor = HYD_themeColor.CGColor;
    _levelLabel.layer.borderWidth = 1.5;
    _levelLabel.font = HYD_font(12.f);
    _levelLabel.textAlignment = NSTextAlignmentCenter;
    
    _typeLabel.layer.cornerRadius = 5;
    _typeLabel.layer.masksToBounds = YES;
    _typeLabel.layer.borderColor = HYD_themeColor.CGColor;
    _typeLabel.layer.borderWidth = 1.5;
    _typeLabel.font = HYD_font(12.f);
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    
    _addressLabel.numberOfLines = 0;
    _addressLabel.font = HYD_font(12.f);
    
    _messageView.layer.cornerRadius = 5;
    _messageView.layer.masksToBounds = YES;
    _messageView.layer.borderColor = HYD_themeColor.CGColor;
    _messageView.layer.borderWidth = .5;
    _messageView.backgroundColor = [UIColor whiteColor];
    
    _iconImageView.layer.cornerRadius = 5;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.borderColor = HYD_themeColor.CGColor;
    _iconImageView.layer.borderWidth = .5;
    
    [_scrollView addSubview:_mapView];
    [_scrollView addSubview:_iconImageView];
    [_scrollView addSubview:_nameLabel];
    [_scrollView addSubview:_levelLabel];
    [_scrollView addSubview:_typeLabel];
    [_scrollView addSubview:introduceLabel];
    [_scrollView addSubview:_messageView];
    [_scrollView addSubview:_telButton];
    [_scrollView addSubview:_addressLabel];
    [_scrollView addSubview:_label];
    
    _telButton.backgroundColor = HYD_themeColor;
    
}


@end
