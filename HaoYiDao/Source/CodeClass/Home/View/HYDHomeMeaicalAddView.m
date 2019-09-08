//
//  HYDHomeMeaicalAddView.m
//  HaoYiDao
//
//  Created by capecao on 16/9/7.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeMeaicalAddView.h"

@interface HYDHomeMeaicalAddView ()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

#define commonHeight 50

@implementation HYDHomeMeaicalAddView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self p_setupView];
    }
    return self;
}

- (void) p_setupView {
    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.userNameTF = [[UITextField alloc]init];
    self.drugNameTF = [[UITextField alloc]init];
    self.startTimeLab = [[UILabel alloc]init];
    self.startTimeBt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self.repeatLab = [[UILabel alloc]init];
    self.repeatBt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self.takeTimesLab = [[UILabel alloc]init];
    self.takeTimesBt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self.remarksTV = [[UITextView alloc]init];
    self.saveBt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];

    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 350 * HEIGHTSCALE)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];
    
    _saveBt.frame = CGRectMake(self.frame.size.width * .1, CGRectGetMaxY(_scrollView.frame) + 50 * HEIGHTSCALE, self.frame.size.width * .8, 40 * HEIGHTSCALE);
    _saveBt.layer.masksToBounds = YES;
    _saveBt.layer.cornerRadius = 6 * HEIGHTSCALE;
    _saveBt.backgroundColor = HYD_themeColor;
    [_saveBt setTitle:@"保存" forState:(UIControlStateNormal)];
    [_saveBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:_saveBt];
    
    [self p_setupItemView];

}

- (void) p_setupItemView {
    
    
    CGRect frame0 = CGRectMake(0, 0, self.frame.size.width, commonHeight);
    CGRect frame1 = CGRectMake(0, CGRectGetMaxY(frame0), CGRectGetWidth(frame0), commonHeight);
    CGRect frame2 = CGRectMake(0, CGRectGetMaxY(frame1), CGRectGetWidth(frame0), commonHeight);
    CGRect frame3 = CGRectMake(0, CGRectGetMaxY(frame2), CGRectGetWidth(frame0), commonHeight);
    CGRect frame4 = CGRectMake(0, CGRectGetMaxY(frame3), CGRectGetWidth(frame0), commonHeight);
    CGRect frame5 = CGRectMake(0, CGRectGetMaxY(frame4), CGRectGetWidth(frame0), commonHeight);
    
    _scrollView.contentSize = CGSizeMake(0, commonHeight * 7);
    
    [self p_setupItem_0:frame0 :_userNameTF :@"服药人"];
    [self p_setupItem_0:frame1 :_drugNameTF :@"药品"];
    [self p_setupItem_2:frame2 :_startTimeLab :@"开始日期" ];
    [self p_setupItem_2:frame3 :_repeatLab :@"重复"];
    [self p_setupItem_2:frame4 :_takeTimesLab :@"服药次数"];
    [self p_setupItem_3:frame5];
    
    _userNameTF.placeholder = @"请添加服药人";
    _drugNameTF.placeholder = @"请添加用药";

    _startTimeBt.frame = frame2;
    _repeatBt.frame = frame3;
    _takeTimesBt.frame = frame4;
    
    [_scrollView addSubview:_startTimeBt];
    [_scrollView addSubview:_repeatBt];
    [_scrollView addSubview:_takeTimesBt];
}

- (void) p_setupItem_0:(CGRect)frame :(UITextField *)textField :(NSString *)name{
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.frame = CGRectMake(CGRectGetMinX(frame) + 10 * WIDTHTSCALE,
                                CGRectGetMinY(frame),
                                frame.size.width * .25 - 20 * WIDTHTSCALE,
                                frame.size.height);
    nameLab.font = HYD_font_MEDIUM(16.f);
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.text = name;

    [_scrollView addSubview:nameLab];
    
    textField.frame = CGRectMake(CGRectGetMaxX(nameLab.frame) + 10 * WIDTHTSCALE,
                                   CGRectGetMinY(nameLab.frame),
                                   frame.size.width - CGRectGetMaxX(nameLab.frame) -
                                   20 * WIDTHTSCALE,
                                   CGRectGetHeight(nameLab.frame));
    [_scrollView addSubview:textField];
    
    textField.returnKeyType = UIReturnKeyDone;
    textField.font = HYD_font(16.f);

}


- (void) p_setupItem_2:(CGRect)frame :(UILabel *)label :(NSString *)name{
    
    UILabel *nameLab = [[UILabel alloc]init];;
    nameLab.frame = CGRectMake(CGRectGetMinX(frame) + 10 * WIDTHTSCALE,
                               CGRectGetMinY(frame),
                               frame.size.width * .25 - 20 * WIDTHTSCALE,
                               frame.size.height);
    nameLab.font = HYD_font_MEDIUM(16.f);
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.text = name;
    
    [_scrollView addSubview:nameLab];
    
    label.frame = CGRectMake(CGRectGetMaxX(nameLab.frame) + 10 * WIDTHTSCALE,
                                   CGRectGetMinY(nameLab.frame),
                                   frame.size.width - CGRectGetMaxX(nameLab.frame) -
                                   50 * WIDTHTSCALE,
                                   CGRectGetHeight(nameLab.frame));
    label.font = HYD_font(16.f);
    [_scrollView addSubview:label];
    
    UIImageView *img = [[UIImageView alloc]init];
    img.frame = CGRectMake(CGRectGetMaxX(label.frame) + 10 * WIDTHTSCALE,
                           CGRectGetMinY(nameLab.frame) + commonHeight * .5 - 8 * WIDTHTSCALE,
                           8 * WIDTHTSCALE, 16 * WIDTHTSCALE);
    img.image = [UIImage imageNamed:@"icon_more_rightforward"];
    [_scrollView addSubview:img];
    
}

- (void) p_setupItem_3:(CGRect)frame {
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.frame = CGRectMake(CGRectGetMinX(frame) + 10 * WIDTHTSCALE,
                               CGRectGetMinY(frame),
                               frame.size.width * .25 - 20 * WIDTHTSCALE,
                               frame.size.height);
    nameLab.font = HYD_font_MEDIUM(16.f);
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.text = @"备注";
    
    [_scrollView addSubview:nameLab];
    
    _remarksTV.frame = CGRectMake(CGRectGetMaxX(nameLab.frame) + 10 * WIDTHTSCALE,
                                   CGRectGetMinY(nameLab.frame),
                                   frame.size.width - CGRectGetMaxX(nameLab.frame) -
                                   20 * WIDTHTSCALE,
                                   CGRectGetHeight(nameLab.frame));
    _remarksTV.text = @"...";
    _remarksTV.textColor = [UIColor colorwithHexString:@"#9e9e9e"];
    _remarksTV.font = HYD_font(16.f);
    [_scrollView addSubview:_remarksTV];

}


@end
