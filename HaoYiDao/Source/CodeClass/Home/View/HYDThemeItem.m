//
//  HYDThemeItem.m
//  HaoYiDao
//
//  Created by Sprixin on 16/9/1.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDThemeItem.h"

@implementation HYDThemeItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupView];
    }
    
    return self;
}

- (void) p_setupView {
    
    self.bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(2.5,
                                                                  2.5,
                                                                  self.frame.size.width - 5,
                                                                  self.frame.size.height - 5)];
    _bgImgView.backgroundColor = [UIColor redColor];
    [self addSubview:_bgImgView];
    
    
    self.button = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _button.backgroundColor = [UIColor clearColor];
    _button.frame = self.bounds;
    [self addSubview:_button];
    
    
}


- (void) p_setupLine {
    
    /*画线及孤线*/
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    //绘制虚曲线
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);//线条颜色
    CGFloat dashArray2[] = {3, 2,};
    CGContextSetLineDash(context, 0, dashArray2, 2);//画虚线
    CGContextMoveToPoint(context,CGRectGetMinX(_bgImgView.frame) + 2.5, CGRectGetMinY(_bgImgView.frame) + 2.5);//开始画线, x，y 为开始点的坐标
    CGContextAddLineToPoint(context,CGRectGetMaxX(_bgImgView.frame) - 2.5, CGRectGetMinY(_bgImgView.frame) + 2.5);
    CGContextAddLineToPoint(context,CGRectGetMaxX(_bgImgView.frame) - 2.5, CGRectGetMaxY(_bgImgView.frame) - 2.5);
    CGContextAddLineToPoint(context,CGRectGetMinX(_bgImgView.frame) - 2.5, CGRectGetMinY(_bgImgView.frame) - 2.5);
    CGContextAddLineToPoint(context,CGRectGetMinX(_bgImgView.frame) + 2.5, CGRectGetMinY(_bgImgView.frame) + 2.5);//画直线, x，y 为线条结束点的坐标

//    CGContextAddCurveToPoint(context, 200, 50, 100, 400, 300, 400);
    
    CGContextStrokePath(context);//开始画线
}


@end
