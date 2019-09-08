//
//  JYIsAutoWarrings.m
//  JYFSKElectricity
//
//  Created by Sprixin on 16/7/19.
//  Copyright © 2016年 sprixin. All rights reserved.
//

#import "HYDMedicationWarring.h"


@interface HYDMedicationWarring ()

@property (nonatomic,strong) NSTimer *circleTimer;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) UILocalNotification *notification;

@end

static HYDMedicationWarring *warrings = nil;

#define CUSTOMUSER_obj @"customUserObject"

@implementation HYDMedicationWarring

+ (instancetype) shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        warrings = [[HYDMedicationWarring alloc]init];
    });
    return warrings;
}

- (void) IsRequestWarrings {
    
    NSArray *array = [MedicationModel MR_findAll];
    NSMutableArray *warringArray = [NSMutableArray array];
    for (MedicationModel *model in array) {
        
        if ([model.warring isEqualToString:@"1"]) {
            [warringArray addObject:model];
        }
    }
    
    if (_circleTimer) {
        /*将计时器从runloop中移出的方法*/
        [_circleTimer invalidate];
    }
    
    if (_notification) {
        [[UIApplication sharedApplication] cancelLocalNotification:_notification];
        _notification = nil;
    }
    
    if (warringArray.count > 0)
        [self p_autoCheckWarrings:warringArray];

}

- (void) p_autoCheckWarrings:(NSMutableArray *)array {
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    self.message = @"";
    NSDate *fireDate = [formatter dateFromString:[NSString stringWithFormat:@"2222年12月12日 08:00"]];
    int count = 1;
    int coum = 7;
    for (MedicationModel *model in array) {
        
        NSDate *date = [formatter dateFromString:
                        [NSString stringWithFormat:@"%@ 08:00",model.startTime]];
        fireDate = [date earlierDate:fireDate];
        NSCharacterSet *numberSet = [[NSCharacterSet decimalDigitCharacterSet]invertedSet];
        /*用药次数*/
        int number = [[model.takeTimes stringByTrimmingCharactersInSet:numberSet] intValue];
        /*重复次数*/
        int count = 1;
        if ([model.repeat isEqualToString:@"每2日"]) {
            count = 2;
        }else if ([model.repeat isEqualToString:@"每周"]){
            count = 7;
        }
        coum = count<coum?count:coum;
        count = number>count?number:count;
        _message = [_message stringByAppendingString:[NSString stringWithFormat:@"请记得提醒%@服用%@,%@%@ \n",model.userName,model.drugName,model.repeat,model.takeTimes]];
    }
    
    double interval = coum * 24 * 60 * 60 / count;
    self.circleTimer = [[NSTimer alloc]initWithFireDate:fireDate interval:interval target:self selector:@selector(circleTimerAct:) userInfo:CUSTOMUSER_obj repeats:YES];
//    self.circleTimer = [[NSTimer alloc]initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:0] interval:10.f target:self selector:@selector(circleTimerAct:) userInfo:CUSTOMUSER_obj repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:_circleTimer forMode:NSDefaultRunLoopMode];
    
}

-(void) circleTimerAct:(NSTimer *)sender {
   
    /* 设置本地推送参数，并进行推送*/
    self.notification = [[UILocalNotification alloc] init];
    /* 设置5秒之后 */
    NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:5];
    
    if (_notification != nil) {
        /* 设置推送时间（0秒后）*/
        _notification.fireDate = pushDate;
        /* 设置时区（此为默认时区）*/
        _notification.timeZone = [NSTimeZone defaultTimeZone];
        /* 设置重复间隔（默认0，不重复推送）*/
        _notification.repeatInterval = 0;
        /* 推送声音（系统默认）*/
        _notification.soundName = UILocalNotificationDefaultSoundName;
        /* 推送内容 */
        _notification.alertBody = @"好医道提示：请按时用药";
        /* 显示在icon上的数字 */
        _notification.applicationIconBadgeNumber = 1;
        /* 设置userinfo 方便在之后需要撤销的时候使用 */
        NSDictionary *info = [NSDictionary dictionaryWithObject:_message
                                                         forKey:HYD_MEDICATION_NOTIFICATION];
        _notification.userInfo = info;
        /* 添加推送到UIApplication */
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:_notification];
    }
}

@end
