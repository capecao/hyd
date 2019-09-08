//
//  HYDSelfExaminationView.m
//  HaoYiDao
//
//  Created by capecao on 16/5/28.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSelfExaminationView.h"


@implementation HYDSelfExaminationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self p_setupView:frame];
        
    }
    return self;
}

- (void) p_setupView:(CGRect)frame {
    
    self.backgroundColor = [UIColor whiteColor];

    self.sexImageView= [[UIImageView alloc]initWithFrame:frame];
    _sexImageView.image = [UIImage imageNamed:@"male"];
    [self addSubview:_sexImageView];
    
    CGFloat Diameter = 5 * (self.bounds.size.height - 64) / 54 ;
    CGFloat Interval = Diameter * .2;
    _diameter = Diameter;
    CGFloat Interval_0 = ([UIScreen mainScreen].bounds.size.width - 4 * Diameter) * .2;
    
#pragma top
    
    self.body100Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body100Bt.frame = CGRectMake(Interval_0, Interval * 2, Diameter, Diameter) ;
    
    self.body101Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body101Bt.frame = CGRectMake(CGRectGetMaxX(_body100Bt.frame) + Interval_0,
                                  CGRectGetMinY(_body100Bt.frame),
                                  Diameter,
                                  Diameter);
    
    self.body102Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body102Bt.frame = CGRectMake(CGRectGetMaxX(_body101Bt.frame) + Interval_0,
                                  CGRectGetMinY(_body100Bt.frame),
                                  Diameter,
                                  Diameter);
    
    self.body103Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body103Bt.frame = CGRectMake(CGRectGetMaxX(_body102Bt.frame) + Interval_0,
                                  CGRectGetMinY(_body100Bt.frame),
                                  Diameter,
                                  Diameter) ;
    
#pragma head
    
    self.body104Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body104Bt.frame = CGRectMake(5,
                                  CGRectGetMaxY(_body100Bt.frame) + Interval,
                                  Diameter,
                                  Diameter) ;
    
    self.body105Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body105Bt.frame = CGRectMake(CGRectGetMaxX(_body104Bt.frame) + Interval_0,
                                  CGRectGetMinY(_body104Bt.frame),
                                  Diameter,
                                  Diameter);
    
    self.body106Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body106Bt.frame = CGRectMake(self.bounds.size.width - 5 - Diameter * 2 - Interval_0,
                                  CGRectGetMinY(_body104Bt.frame),
                                  Diameter,
                                  Diameter);
    
    self.body107Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body107Bt.frame = CGRectMake(CGRectGetMaxX(_body106Bt.frame) + Interval_0,
                                  CGRectGetMinY(_body104Bt.frame),
                                  Diameter,
                                  Diameter) ;
    
#pragma body
    
    self.body108Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body108Bt.frame = CGRectMake(CGRectGetMinX(_body100Bt.frame),
                                  CGRectGetMaxY(_body104Bt.frame) + Interval,
                                  Diameter,
                                  Diameter) ;
    
    self.body109Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body109Bt.frame = CGRectMake(CGRectGetMinX(_body103Bt.frame),
                                  CGRectGetMinY(_body108Bt.frame),
                                  Diameter,
                                  Diameter);
    
    self.body110Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body110Bt.frame = CGRectMake(CGRectGetMinX(_body100Bt.frame),
                                  CGRectGetMaxY(_body108Bt.frame) + Interval,
                                  Diameter,
                                  Diameter) ;
    
    self.body111Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body111Bt.frame = CGRectMake(CGRectGetMinX(_body103Bt.frame),
                                  CGRectGetMinY(_body110Bt.frame),
                                  Diameter,
                                  Diameter);
    
    self.body112Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body112Bt.frame = CGRectMake(CGRectGetMinX(_body100Bt.frame),
                                  CGRectGetMaxY(_body110Bt.frame) + Interval,
                                  Diameter,
                                  Diameter) ;
    
    self.body113Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body113Bt.frame = CGRectMake(CGRectGetMinX(_body103Bt.frame),
                                  CGRectGetMinY(_body112Bt.frame),
                                  Diameter,
                                  Diameter);
    
    self.body114Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body114Bt.frame = CGRectMake(CGRectGetMinX(_body100Bt.frame),
                                  CGRectGetMaxY(_body112Bt.frame) + Interval,
                                  Diameter,
                                  Diameter) ;
    
    self.body115Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body115Bt.frame = CGRectMake(CGRectGetMinX(_body103Bt.frame),
                                  CGRectGetMinY(_body114Bt.frame),
                                  Diameter,
                                  Diameter);
    
    self.body116Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body116Bt.frame = CGRectMake(CGRectGetMinX(_body100Bt.frame),
                                  CGRectGetMaxY(_body114Bt.frame) + Interval,
                                  Diameter,
                                  Diameter) ;
    
    self.body117Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body117Bt.frame = CGRectMake(CGRectGetMinX(_body103Bt.frame),
                                  CGRectGetMinY(_body116Bt.frame),
                                  Diameter,
                                  Diameter);
    
#pragma center
    
    self.body118Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body118Bt.frame = CGRectMake(self.center.x - Diameter / 2,
                                  CGRectGetMaxY(_body108Bt.frame) + Interval / 2 - Diameter / 2,
                                  Diameter,
                                  Diameter) ;
    
    self.body119Bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _body119Bt.frame = CGRectMake(CGRectGetMinX(_body118Bt.frame),
                                  CGRectGetMaxY(_body118Bt.frame) + Interval,
                                  Diameter,
                                  Diameter);
    
#pragma function
    
    self.sexBt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _sexBt.frame = CGRectMake(Interval_0 / 2,
                              CGRectGetMaxY(_body116Bt.frame) + Diameter * .8,
                              Diameter * .8,
                              Diameter * .8);
    
    self.aroundBt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _aroundBt.frame = CGRectMake(self.bounds.size.width - Interval_0 / 2 - Diameter * .8,
                                 CGRectGetMinY(_sexBt.frame),
                                 CGRectGetWidth(_sexBt.frame),
                                 CGRectGetHeight(_sexBt.frame));
    
    [self p_setFeatures:_body100Bt :@"100"];
    [self p_setFeatures:_body101Bt :@"101"];
    [self p_setFeatures:_body102Bt :@"102"];
    [self p_setFeatures:_body103Bt :@"103"];
    
    [self p_setFeatures:_body104Bt :@"104"];
    [self p_setFeatures:_body105Bt :@"105"];
    [self p_setFeatures:_body106Bt :@"106"];
    [self p_setFeatures:_body107Bt :@"107"];
    
    [self p_setFeatures:_body108Bt :@"108"];
    [self p_setFeatures:_body109Bt :@"109"];
    [self p_setFeatures:_body110Bt :@"110"];
    [self p_setFeatures:_body111Bt :@"111"];
    
    [self p_setFeatures:_body112Bt :@"112"];
    [self p_setFeatures:_body113Bt :@"113"];
    [self p_setFeatures:_body114Bt :@"114"];
    [self p_setFeatures:_body115Bt :@"115"];

    [self p_setFeatures:_body116Bt :@"116"];
    [self p_setFeatures:_body117Bt :@"117"];

    [self p_setFeatures:_body118Bt :@"118"];
    [self p_setFeatures:_body119Bt :@"119"];
    
    [self p_setFeature:_sexBt :@"sex_switch"];
    [self p_setFeature:_aroundBt :@"around_switch"];

    
}

- (void) p_setFeatures:(UIButton *)button :(NSString *)imageName{
    
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    [button setImage:nil forState:(UIControlStateNormal)];
    button.tag = 10000 + [imageName intValue];
    [self addSubview:button];
    
}

- (void) p_setFeature:(UIButton *)button :(NSString *)imageName{
    
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    [button setImage:nil forState:(UIControlStateNormal)];
    [self addSubview:button];
    
}


@end
