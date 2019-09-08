//
//  HYDUserProducerVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/20.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDUserProducerVC.h"

@interface HYDUserProducerVC ()

@end

@implementation HYDUserProducerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self p_setupView];
}

- (void) p_setupView {
    
    UILabel *emailLab = [[UILabel alloc]init];
    emailLab.frame = CGRectMake(0, self.view.frame.size.height * .3,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height * .2);
    [self.view addSubview:emailLab];
    
    emailLab.font = HYD_font(14.f);
    emailLab.textAlignment = NSTextAlignmentCenter;
    emailLab.textColor = [UIColor colorwithHexString:@"#414141"];
    emailLab.text = @"意见或建议请至 capecao@sina.com";
    
    UILabel *producerLab = [[UILabel alloc]init];
    producerLab.frame = CGRectMake(0, self.view.frame.size.height * .6,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height * .2);
    [self.view addSubview:producerLab];
    
    producerLab.font = HYD_font(14.f);
    producerLab.textAlignment = NSTextAlignmentCenter;
    producerLab.textColor = [UIColor colorwithHexString:@"#414141"];
    producerLab.text = @"好医道 All rights by cape";
    
}


@end
