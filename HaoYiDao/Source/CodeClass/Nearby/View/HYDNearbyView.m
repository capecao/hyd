//
//  HYDNearbyView.m
//  HaoYiDao
//
//  Created by Sprixin on 16/6/1.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNearbyView.h"

@implementation HYDNearbyView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    
    return self;
}

- (void) setupView {
    
    self.mapView = [[MAMapView alloc]initWithFrame:self.bounds];
    _mapView.showsCompass = YES;
    _mapView.showsUserLocation = YES;
    _mapView.showsScale = YES;
    [self addSubview:_mapView];
    
    self.segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"医院",@"药店"]];
    _segmentControl.frame = CGRectMake(self.frame.size.width * .2,
                                       5 * HEIGHTSCALE,
                                       self.frame.size.width * .6,
                                       36 * HEIGHTSCALE);
    
    _segmentControl.backgroundColor = [UIColor colorwithHexString:@"#F5F6F8"];
    _segmentControl.layer.cornerRadius = 4;
    _segmentControl.layer.borderWidth = 2;
    _segmentControl.layer.borderColor = HYD_themeColor.CGColor;
    _segmentControl.layer.masksToBounds = YES;
    _segmentControl.selectedSegmentIndex = 0;
    _segmentControl.tintColor= HYD_themeColor;
    _segmentControl.alpha = .8;
    
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                             NSForegroundColorAttributeName: [UIColor whiteColor]};
    [_segmentControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                               NSForegroundColorAttributeName:HYD_themeColor};
    
    [_segmentControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [self addSubview:_segmentControl];
}

@end
