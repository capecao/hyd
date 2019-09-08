//
//  HYDHealthChencView.h
//  HaoYiDao
//
//  Created by capecao on 2017/4/22.
//  Copyright © 2017年 cape. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYDHealthCheckView : UIView

@property (nonatomic,strong) UILabel *cityLab;
@property (nonatomic,strong) UILabel *weatherLab;
@property (nonatomic,strong) UILabel *windLab;

@property (nonatomic,strong) UIButton *dismissBt;
@property (nonatomic,strong) UIButton *diseaseBt; // 疾病
@property (nonatomic,strong) UIButton *sectionBt; // 科室
@property (nonatomic,strong) UIButton *selfcheckBt; // 自查
@property (nonatomic,strong) UIButton *drugBt; // 药品

@property (nonatomic,strong) UIButton *infoBt; // 健康咨询
@property (nonatomic,strong) UIButton *knownBt; // 健康知识
@property (nonatomic,strong) UIButton *askBt; // 健康问答
@property (nonatomic,strong) UIButton *bookBt; // 健康书籍

@end
