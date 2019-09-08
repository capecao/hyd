//
//  HYDNearbyHospitalVIew.h
//  HaoYiDao
//
//  Created by Sprixin on 16/6/2.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYDNearbyCommon.h"

@interface HYDNearbyHospitalVIew : UIView

@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *levelLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIWebView *messageView;
@property (nonatomic,strong) UIButton *telButton;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *label;

@end
