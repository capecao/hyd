//
//  HYDHomeMeaicalAddView.h
//  HaoYiDao
//
//  Created by capecao on 16/9/7.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYDHomeMeaicalAddView : UIView

@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UITextField *drugNameTF;
@property (nonatomic,strong) UILabel *startTimeLab;
@property (nonatomic,strong) UIButton *startTimeBt;
@property (nonatomic,strong) UILabel *repeatLab;
@property (nonatomic,strong) UIButton *repeatBt;
@property (nonatomic,strong) UILabel *takeTimesLab;
@property (nonatomic,strong) UIButton *takeTimesBt;
@property (nonatomic,strong) UITextView *remarksTV;
@property (nonatomic,strong) UIButton *saveBt;

@end
