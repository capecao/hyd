//
//  CustomAnnotationView.h
//  HYDHelper
//
//  Created by capecao on 16/1/16.
//  Copyright © 2016年 capecao. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;

@end
