//
//  CustomAnnotationView.m
//  HYDHelper
//
//  Created by capecao on 16/1/16.
//  Copyright © 2016年 capecao. All rights reserved.
//

#import "CustomAnnotationView.h"

@class CustomCalloutView;

@interface CustomAnnotationView ()

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;

@end

#define kCalloutWidth [UIScreen mainScreen].bounds.size.width * .7
#define kCalloutHeight [UIScreen mainScreen].bounds.size.height * .3

@implementation CustomAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (self.selected == selected) {
        return; }
    if (selected) {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0,
                                                                                   0,
                                                                                   kCalloutWidth,
                                                                                   kCalloutHeight)];
            
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  - CGRectGetHeight(self.calloutView.bounds) / 2.f +
                                                  self.calloutOffset.y);
        }
        
        [self addSubview:self.calloutView];
        
    }
    else {
        [self.calloutView removeFromSuperview];
    }
    [super setSelected:selected animated:animated];
}

@end
