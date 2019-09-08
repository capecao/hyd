//
//  HYDHomeMedicalAddVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/7.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeMedicalAddVC.h"
#import "HYDHomeMeaicalAddView.h"
#import "HYDDatePickerView.h"
#import "HYDHomePageCommon.h"

@interface HYDHomeMedicalAddVC ()<UITextFieldDelegate,UITextViewDelegate>
{
    CGFloat HeightForCell2;
}
@property (nonatomic,strong) HYDHomeMeaicalAddView *addView;
@property (nonatomic,strong) UIButton *saveBt;
@property (nonatomic,strong) HYDDatePickerView *datePickerView;

@end

@implementation HYDHomeMedicalAddVC

- (void)loadView {
    [super loadView];
    
    self.addView = [[HYDHomeMeaicalAddView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _addView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用药管理";
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (!_model) {
        self.model = [MedicationModel MR_createEntity];
    }

    [self p_setupViewFeatures];
    
}

-(void) p_setupViewFeatures {
    
    
    _model.startTime = [self getNowTime];
    _model.repeat = @"每日";
    _model.takeTimes = @"2次";
    _model.remarks = @"";
    _model.warring = @"0";
    
    _addView.userNameTF.text = _model.userName;
    _addView.drugNameTF.text = _model.drugName;
    _addView.startTimeLab.text = _model.startTime;
    _addView.repeatLab.text = _model.repeat;
    _addView.takeTimesLab.text = _model.takeTimes;
    _addView.remarksTV.text = _model.remarks;
    
    _addView.userNameTF.delegate = self;
    _addView.drugNameTF.delegate = self;
    _addView.remarksTV.delegate = self;
    
    [_addView.startTimeBt addTarget:self action:@selector(setDatePickerAct:)
                   forControlEvents:(UIControlEventTouchUpInside)];
    [_addView.repeatBt addTarget:self action:@selector(repeatAct:)
                forControlEvents:(UIControlEventTouchUpInside)];
    [_addView.takeTimesBt addTarget:self action:@selector(takeTimesAct:)
                   forControlEvents:(UIControlEventTouchUpInside)];
    [_addView.saveBt addTarget:self action:@selector(saveAct:)
              forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void) setDatePickerAct:(UIButton *)sender {
    
    if (_datePickerView) {
        [_datePickerView removeFromSuperview];
    }
    self.datePickerView = [[HYDDatePickerView alloc]initWithFrame:_addView.bounds];
    [_addView addSubview:_datePickerView];
    
    [_datePickerView.confirmButton addTarget:self action:@selector(datePickeConfirmAct:)
                            forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void) datePickeConfirmAct:(UIButton *)sender {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [UIView animateWithDuration:.3 animations:^{
        _datePickerView.bottom = _datePickerView.height;
        
    }];
    _addView.startTimeLab.text = [self timeFormat];
    [_datePickerView removeFromSuperview];
}

- (NSString *) getNowTime {
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |
    NSCalendarUnitDay | NSCalendarUnitHour |
    NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int year = (int)[dateComponent year];
    int month = (int)[dateComponent month];
    int day = (int)[dateComponent day];
    
    return [NSString stringWithFormat:@"%d年%d月%d日",year,month,day];
}

- (NSString *)timeFormat {
    
    NSDate *selected = [_datePickerView.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentOlderOneDateStr = [dateFormatter stringFromDate:selected];
    
    return currentOlderOneDateStr;
}

- (void) repeatAct:(UIButton *)sender {
    
    NSArray *messages = @[@"每日",@"每2日",@"每周"];
    
    UIAlertController *alertC =
    [UIAlertController alertControllerWithTitle:nil
                                        message:nil
                                 preferredStyle:(UIAlertControllerStyleActionSheet)];
    for (int i = 0; i < 3; i ++) {
        
        UIAlertAction *act =
        [UIAlertAction actionWithTitle:messages[i]
                                 style:(UIAlertActionStyleDefault)
                               handler:^(UIAlertAction * _Nonnull action) {
                                   _addView.repeatLab.text = messages[i];
                               }];
        [alertC addAction:act];
    }
    [self presentViewController:alertC animated:YES completion:nil];
    
}

- (void) takeTimesAct:(UIButton *)sender {
    
    NSArray *messages = @[@"1次",@"2次",@"3次"];
    
    UIAlertController *alertC =
    [UIAlertController alertControllerWithTitle:nil
                                        message:nil
                                 preferredStyle:(UIAlertControllerStyleActionSheet)];
    for (int i = 0; i < 3; i ++) {
        
        UIAlertAction *act =
        [UIAlertAction actionWithTitle:messages[i]
                                 style:(UIAlertActionStyleDefault)
                               handler:^(UIAlertAction * _Nonnull action) {
                                   _addView.takeTimesLab.text = messages[i];
                               }];
        [alertC addAction:act];
    }
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void) saveAct:(UIButton *)sender {
    
    NSString *message = @"";
    bool flag = true;
    
    _model.userName = _addView.userNameTF.text;
    _model.drugName = _addView.drugNameTF.text;
    _model.startTime = _addView.startTimeLab.text;
    _model.repeat = _addView.repeatLab.text;
    _model.takeTimes = _addView.takeTimesLab.text;
    _model.remarks = _addView.remarksTV.text;
    
    if (!_model.userName) {
        message = @"请输入服药人！";
        flag = false;
    }
    if (!_model.drugName) {
        message = @"请输入用药！";
        flag = false;
    }
    if (!_model.startTime) {
        message = @"请输入开始时间！";
        flag = false;
    }
    if (!_model.repeat) {
        message = @"请输入重复时间！";
        flag = false;
    }
    if (!_model.takeTimes) {
        message = @"请输入服药次数！";
        flag = false;
    }
    if (!_model.remarks) {
        _model.remarks = @"备注用药说明";
    }
    if (!_model.warring) {
        _model.warring = @"0";
    }
    
    
    if (flag) {
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [ProgressHUD showSuccess:@"已经加入用药管理"];
        
        }else {
        
            UIAlertController *alertC =
        [UIAlertController alertControllerWithTitle:@"提示"
                                            message:message
                                     preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定"
                                                         style:(UIAlertActionStyleCancel)
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           
                                                       }];
        [alertC addAction:cancel];
        [self presentViewController:alertC animated:YES completion:nil];
        
    }
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:_addView.userNameTF])
        _model.userName = textField.text;
    
    if ([textField isEqual:_addView.drugNameTF])
        _model.drugName = textField.text;
}

@end
