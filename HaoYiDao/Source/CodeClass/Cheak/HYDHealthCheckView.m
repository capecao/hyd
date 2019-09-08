//
//  HYDHealthChencView.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/22.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "HYDHealthCheckView.h"

@implementation HYDHealthCheckView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:.9];
        [self setupView];
    }
    return self;
}

- (void) setupView {
    
    self.dismissBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self addSubview:_dismissBt];
    [_dismissBt setBackgroundImage:IMAGENAME(@"icon_check_close")
                          forState:(UIControlStateNormal)];
    
    
    self.diseaseBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self addSubview:_diseaseBt];
    _diseaseBt.tag = 1000;
    [_diseaseBt setBackgroundImage:IMAGENAME(@"icon_diseases_check")
                          forState:(UIControlStateNormal)];
    
    self.sectionBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self addSubview:_sectionBt];
    _sectionBt.tag = 1001;
    [_sectionBt setBackgroundImage:IMAGENAME(@"icon_section_check")
                          forState:(UIControlStateNormal)];
    
    self.selfcheckBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self addSubview:_selfcheckBt];
    _selfcheckBt.tag = 1002;
    [_selfcheckBt setBackgroundImage:IMAGENAME(@"icon_self_check")
                          forState:(UIControlStateNormal)];
    
    self.drugBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self addSubview:_drugBt];
    _drugBt.tag = 1003;
    [_drugBt setBackgroundImage:IMAGENAME(@"icon_drug_check")
                          forState:(UIControlStateNormal)];
    
    self.infoBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self addSubview:_infoBt];
    _infoBt.tag = 1004;
    [_infoBt setBackgroundImage:IMAGENAME(@"icon_info_check")
                       forState:(UIControlStateNormal)];
    
    self.knownBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self addSubview:_knownBt];
    _knownBt.tag = 1005;
    [_knownBt setBackgroundImage:IMAGENAME(@"icon_known_check")
                       forState:(UIControlStateNormal)];
    
    self.askBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self addSubview:_askBt];
    _askBt.tag = 1006;
    [_askBt setBackgroundImage:IMAGENAME(@"icon_ask_check")
                       forState:(UIControlStateNormal)];
    
    self.bookBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self addSubview:_bookBt];
    _bookBt.tag = 1007;
    [_bookBt setBackgroundImage:IMAGENAME(@"icon_book_check")
                       forState:(UIControlStateNormal)];
    
    self.cityLab = [[UILabel alloc]init];
    [self addSubview:_cityLab];
    
    self.weatherLab = [[UILabel alloc]init];
    [self addSubview:_weatherLab];
    
    self.windLab = [[UILabel alloc]init];
    [self addSubview:_windLab];
    
    [_dismissBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).with.offset(-50 * HEIGHTSCALE);
        make.size.mas_equalTo(CGSizeMake(30 * WIDTHTSCALE, 30 * WIDTHTSCALE));
    }];

    [_diseaseBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY);
        make.centerX.equalTo(self).with.offset(-self.bounds.size.width * .375);
        make.size.mas_equalTo(CGSizeMake(50 * WIDTHTSCALE, 50 * WIDTHTSCALE));
    }];

    [_sectionBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(_diseaseBt);
        make.centerX.equalTo(self).with.offset(-self.bounds.size.width * .125);
    }];

    [_selfcheckBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(_diseaseBt);
        make.centerX.equalTo(self).with.offset(self.bounds.size.width * .125);
    }];

    [_drugBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(_diseaseBt);
        make.centerX.equalTo(self).with.offset(self.bounds.size.width * .375);
    }];
    
    [_infoBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.centerX.equalTo(_diseaseBt);
        make.top.equalTo(_diseaseBt.mas_bottom).with.offset(40 * HEIGHTSCALE);
    }];
    
    [_knownBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerX.width.equalTo(_sectionBt);
        make.top.equalTo(_infoBt);
    }];
    
    [_askBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerX.width.equalTo(_selfcheckBt);
        make.top.equalTo(_infoBt);
    }];
    
    [_bookBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerX.width.equalTo(_drugBt);
        make.top.equalTo(_infoBt);
    }];
    
    [_cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.equalTo(self).with.offset(15 * WIDTHTSCALE);
        make.top.equalTo(self).with.offset(10 * WIDTHTSCALE);
        make.height.equalTo(@(20 * HEIGHTSCALE));
    }];
    
    [_weatherLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.left.height.equalTo(_cityLab);
        make.top.equalTo(_cityLab.mas_bottom);
    }];

    [_windLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.left.height.equalTo(_cityLab);
        make.top.equalTo(_weatherLab.mas_bottom);
    }];

    
    [self setItemButton:_diseaseBt Name:@"疾病"];
    [self setItemButton:_sectionBt Name:@"科室"];
    [self setItemButton:_selfcheckBt Name:@"自检"];
    [self setItemButton:_drugBt Name:@"药品"];
    [self setItemButton:_infoBt Name:@"健康资讯"];
    [self setItemButton:_knownBt Name:@"健康知识"];
    [self setItemButton:_askBt Name:@"健康问答"];
    [self setItemButton:_bookBt Name:@"健康书籍"];
}

-(void) setItemButton:(UIButton *)button Name:(NSString *)name {
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = HYD_themeColor;
    label.text = name;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = HYD_font_MEDIUM(14.f);
    
    [self addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width * .25, 40 * HEIGHTSCALE));
        make.top.equalTo(button.mas_bottom);
    }];
}

@end
