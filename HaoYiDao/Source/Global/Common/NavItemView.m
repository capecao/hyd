//
//  NavItemView.m
//  YUNENGZHE
//
//  Created by Sprixin on 15/12/14.
//  Copyright © 2015年 sprixin. All rights reserved.
//

#import "NavItemView.h"

@implementation NavItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self setupView];
        
    }
    
    return self;
}

- (void) setupView {
    
    self.barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _barButton.frame = CGRectMake(0, 0, self.bounds.size.width, self.frame.size.height);
    [_barButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self addSubview:_barButton];
}


@end
