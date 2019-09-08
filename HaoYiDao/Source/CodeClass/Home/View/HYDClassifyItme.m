//
//  HYDClassifyItme.m
//  HaoYiDao
//
//  Created by Sprixin on 16/9/1.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDClassifyItme.h"

@implementation HYDClassifyItme

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    
    return self;
}

- (void) setupView {
    
    self.bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * .25,
                                                                  5,
                                                                  self.frame.size.width * .5,
                                                                  self.frame.size.width * .5)];
    
    _bgImgView.backgroundColor = [UIColor redColor];
    _bgImgView.layer.cornerRadius = _bgImgView.frame.size.height / 2;
    _bgImgView.layer.masksToBounds = YES;
    [self addSubview:_bgImgView];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(5,
                                                             CGRectGetMaxY(_bgImgView.frame),
                                                             self.frame.size.width - 10,
                                                             self.frame.size.height * .5 - 10)];
    
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = HYD_font(12.f);
    _titleLab.numberOfLines = 0;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLab];
    
    self.button = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _button.frame = self.bounds;
    _button.backgroundColor = [UIColor clearColor];
    [self addSubview:_button];
}


@end
