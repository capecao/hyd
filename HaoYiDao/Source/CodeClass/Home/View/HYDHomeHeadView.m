//
//  HYDHomePageView.m
//  HaoYiDao
//
//  Created by Sprixin on 16/9/1.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeHeadView.h"

@implementation HYDHomeHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self .backgroundColor = [UIColor whiteColor];
        [self p_setupView];
    }
    
    return self;
}

- (void) p_setupView {

    [self p_setupThemeView];
    [self p_setupClassifyView];
    
}

- (void) p_setupThemeView {
    
    CGFloat height = self.frame.size.height * .25;
    CGFloat width = self.frame.size.width / 3;
    
    for (int i = 0; i < 2; i ++) {
        
        for (int j = 0; j < 3; j ++) {
            
            HYDThemeItem *item = [[HYDThemeItem alloc]
                                  initWithFrame:CGRectMake(width * j,
                                                           height * i,
                                                           width,
                                                           height)];
            [self addSubview:item];
            item.bgImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"homepage_theme_%d",3 * i + j]];
            
            item.tag = 1000 + 3 * i + j;
        }
    }
}

- (void) p_setupClassifyView {
    
    CGFloat width = self.frame.size.width / 4;
    CGFloat height = width;
    
    NSArray *titles = @[@"用药管理",@"口袋体检",@"大病罕见病",@"非处方用药",
                        @"孕妇哺乳期妇女用药",@"妇科用药",@"儿童用药",@"男科用药",@"老人用药",@"生活小贴士"];
    
    for (int i = 0; i < 3; i ++) {
        
        for (int j = 0; j < 4; j ++) {
            
            if (4 * i + j < 10) {
                
                HYDClassifyItme *item =
                [[HYDClassifyItme alloc]initWithFrame:
                 CGRectMake(width * j,
                            height * i + self.frame.size.height * .52,
                            width,height)];
                
                [self addSubview:item];
                item.bgImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"homepage_classify_%d",4 * i + j]];
                item.titleLab.text = titles[4 * i + j];
                
                item.tag = 2000 + 4 * i + j;
            }
        }
    }
    
}

@end
