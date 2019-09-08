//
//  HYDTitleView.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/26.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "HYDTitleView.h"

@implementation HYDTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:CGRectMake(0, 0, self.superview.bounds.size.width, self.superview.bounds.size.height)];

}

@end
