//
//  RS_CS_DatePickerView.m
//  RedSun
//
//  Created by Sprixin on 15/12/28.
//  Copyright © 2015年 sprixin. All rights reserved.
//

#import "HYDDatePickerView.h"

@implementation HYDDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:.2 alpha:.2];
        [self setupView];
    }
    
    return self;
}

- (void) setupView {
    
    UIView *backGround = [[UIView alloc]initWithFrame:
                          CGRectMake(self.bounds.size.width * .1,
                                     self.frame.size.height * .3,
                                     self.bounds.size.width * .8,
                                     self.frame.size.height * .4)];
    backGround.backgroundColor = [UIColor whiteColor];
    [self addSubview:backGround];
    
    self.cancelButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _cancelButton.frame = CGRectMake(20, 10, backGround.bounds.size.width / 4, 30);
    
    self.confirmButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    
    _confirmButton.frame = CGRectMake(backGround.bounds.size.width *3 / 4 - 20,
                                      CGRectGetMinY(_cancelButton.frame),
                                      CGRectGetWidth(_cancelButton.frame),
                                      CGRectGetHeight(_cancelButton.frame));
    
    UIView *backView = [[UIView alloc]initWithFrame:
                        CGRectMake(0, 0, backGround.bounds.size.width, 50)];
    
    [backGround addSubview:backView];
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:
                       CGRectMake(0,
                                  CGRectGetMaxY(_cancelButton.frame) + 10,
                                  backGround.bounds.size.width,
                                  backGround.bounds.size.height - 40)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    
    // max min date
    NSString *minDate = [NSString stringWithFormat:@"%ld-%ld-%ld",
                         (long)year,
                         (long)month,
                         (long)day];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
//    _datePicker.maximumDate = [dateFormatter dateFromString:maxDate];
    _datePicker.minimumDate = [dateFormatter dateFromString:minDate];
    
    [backGround addSubview:_datePicker];
    backView.backgroundColor = [UIColor colorwithHexString:@"#ECF0EF"];
    
    [_cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
    _confirmButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    _confirmButton.titleLabel.font = HYD_font_MEDIUM(17.f);
    [_confirmButton setTitleColor:[UIColor colorwithHexString:@"#157EFB"]
                         forState:(UIControlStateNormal)];
    
    [_cancelButton setTitleColor:[UIColor colorwithHexString:@"#157EFB"]
                        forState:(UIControlStateNormal)];
    _cancelButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    _cancelButton.titleLabel.font = HYD_font_MEDIUM(17.f);
    [_confirmButton setTitle:@"确定" forState:(UIControlStateNormal)];
    
    [backView addSubview:_cancelButton];
    [backView addSubview:_confirmButton];
    
    backGround.layer.cornerRadius = 5;
    backGround.layer.masksToBounds = year;
    backGround.layer.borderColor = HYD_themeColor.CGColor;
    backGround.layer.borderWidth = 1.f;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self
                                      action:@selector(tapGesAct:)];
    
    [self addGestureRecognizer:tapGes];
    
    [_cancelButton addTarget:self action:@selector(cancelAct:)
            forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void) tapGesAct:(UITapGestureRecognizer *)sender {
    
    [self removeFromSuperview];
    sender = nil;
}

- (void) cancelAct:(UIButton *)sender {
    
    [self removeFromSuperview];
    sender = nil;
}



@end
