//
//  CustomCalloutView.m
//  YUNENGZHE
//
//  Created by Sprixin on 15/11/18.
//  Copyright © 2015年 sprixin. All rights reserved.
//

#import "CustomCalloutView.h"

#define kPortraitMargin 5
#define kPortraitWidth 70
#define kPortraitHeight 50
#define kTitleWidth 120
#define kTitleHeight 20
#define kArrorHeight 10

@implementation CustomCalloutView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    self.layer.shadowColor = [[UIColor whiteColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}
- (void)drawInContext:(CGContextRef)context {
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
    [self getDrawPath:context];
    CGContextFillPath(context);
}
- (void)getDrawPath:(CGContextRef)context {
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews {
    
    // 添加电站信息
    self.briefView = [[HYDNearby_briefView alloc]initWithFrame:self.bounds];;
    [self addSubview:_briefView];
    
}


@end
