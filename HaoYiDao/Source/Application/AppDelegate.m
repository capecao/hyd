//
//  AppDelegate.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/25.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "AppDelegate.h"
#import "HYDMainTabBarController.h"
#import "HYDNavigationController.h"
#import "HYDSoundPlayManger.h"

//#import <UMSocial.h>
//#import <UMSocialWechatHandler.h>
//#import <UMSocialSinaSSOHandler.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()
{
    CGFloat leftX;
    CGFloat leftX2;
    CGFloat topY;
    CGFloat xSpace;
    CGFloat ySpace;
    CGFloat length;
    
    CGFloat xScale;
    CGFloat yScale;
}
@property (strong, nonatomic) UIImageView *splashView;
@property(nonatomic,assign)CGFloat duration;
@property(nonatomic,strong)UIImageView *one;
@property(nonatomic,strong)UIImageView *two;
@property(nonatomic,strong)UIImageView *three;
@property(nonatomic,strong)UIImageView *word;
@property(nonatomic,strong)UIImageView *logo;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self lanuchAnnimation];
    [self configureMKMAPAPIKey];
    [self configureUMENGAPIKey];
    [self setupLocalNotification];
    [self configureMagicalRecord];
    
    return YES;
}

#pragma mark -------------- 高德地图
- (void) configureMKMAPAPIKey {
    
    if ([MKMAP_APIKEY length] == 0) {
        
        NSString *reason = [NSString stringWithFormat:@"API key值为空，请检查key是否正确"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"API缺失"
                                                       message:reason
                                                      delegate:nil cancelButtonTitle:@"ok"
                                             otherButtonTitles:nil, nil];
        
        [alert show];
    }
    [AMapServices sharedServices].apiKey = (NSString *)MKMAP_APIKEY;
    
}


#pragma mark -------------- 友盟
- (void) configureUMENGAPIKey{
    
//    [UMSocialData setAppKey:UMENG_APIKEY];
//
//    [UMSocialWechatHandler setWXAppId:UMENG_WEIXIN_ID
//                            appSecret:UMENG_WEIXIN_SECRET
//                                  url:APP_APPSTORE_URL];
//
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:UMENG_WEIBO_KEY
//                                              secret:UMENG_WEIBO_SECRET
//                                         RedirectURL:APP_APPSTORE_URL];
}

#pragma mark -------------- MagicalRecord
- (void) configureMagicalRecord {
    // 开启mr日志
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelWarn];
    // 初始化coredata堆栈，也可以指定初始化某个堆栈
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"hydDataModel.sqlite"];
}

- (void) MagicalRecordCleanup {
    // 在退出应用时调用
    [MagicalRecord cleanUp];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // 直接打开app时，图标上的数字清零
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [self MagicalRecordCleanup];
}

#pragma mark -------------- 开启本地通知
- (void) setupLocalNotification {
    
    UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert |
    UIUserNotificationTypeSound;
    UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type
                                                                          categories:nil];
    [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    // 这里真实需要处理交互的地方
    // 获取通知所带的数据
    if (application.applicationState == UIApplicationStateInactive) {
        NSString *notMessage = [notification.userInfo objectForKey:HYD_MEDICATION_NOTIFICATION];
        if (notMessage.length > 5) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:notMessage
                                                           delegate:nil
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles:nil];
            
            [alert show];
            
            [self playSound];
            
            // 更新显示的徽章个数
            NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
            badge--;
            badge = badge >= 0 ? badge : 0;
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
            
        }else {
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
    }
}

- (void) playSound {
    
    
    //1震动
    
    HYDSoundPlayManger *sound1 = [[HYDSoundPlayManger alloc]initForPlayingVibrate];
    [sound1 play];
    
    //2系统音效，以Tock为例
    /*
     HYDSoundPlayManger *sound2 = [[HYDSoundPlayManger alloc]initForPlayingSystemSoundEffectWith:@"Tock"
     ofType:@"aiff"];
     [sound2 play];*/
    
    //3自定义音效，将tap.aif音频文件加入到工程
    /*
     HYDSoundPlayManger *sound3 = [[HYDSoundPlayManger alloc]initForPlayingSoundEffectWith:@"tap.aif"];
     [sound3 play];
     */
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //调用其他SDK，例如支付宝SDK等
//    }
    return false;
}

#pragma mark -------------- 启动动画
- (void) lanuchAnnimation {
    
    [self.window makeKeyAndVisible];
    
    self.splashView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    // 设置启动画面
    [_splashView setImage:[UIImage imageNamed:@"lanuchBackground"]];
    [self.window addSubview:_splashView   ];
    [self.window bringSubviewToFront:_splashView];
    // 计算坐标
    
    xScale = [UIScreen mainScreen].bounds.size.width / 320.0;
    yScale = [UIScreen mainScreen].bounds.size.height / 568.0;
    length = 60 * xScale;
    leftX = 50 *xScale;
    leftX2 = 100 *xScale;
    xSpace = 20 *xScale;
    topY = 100 * yScale;
    ySpace = 150 *yScale;
    
    // 布局
    self.one = [[UIImageView alloc]initWithFrame:CGRectMake(leftX, topY, length, length)];
    _one.image = [UIImage imageNamed:@"好"];
    self.two = [[UIImageView alloc]initWithFrame:CGRectMake(leftX + (length +xSpace)*1, topY, length, length)];
    _two.image = [UIImage imageNamed:@"医"];
    self.three = [[UIImageView alloc]initWithFrame:CGRectMake(leftX + (length +xSpace)*2, topY, length, length)];
    _three.image = [UIImage imageNamed:@"道"];
    self.word = [[UIImageView alloc] initWithFrame:CGRectMake(leftX2, topY + ySpace, 140*xScale, 42*xScale)];
    _word.image = [UIImage imageNamed:@"word"];
    self.logo = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_word.frame)+7,CGRectGetMinY(_word.frame), 30*xScale, 25*xScale)];
    _logo.image = [UIImage imageNamed:@"logo"];
    
    // 设置动画时间
    self.duration = 1.0;
    // 启动动画
    [self performSelector:@selector(animationOne)
               withObject:nil
               afterDelay:0];
    [self performSelector:@selector(animationTwo)
               withObject:nil
               afterDelay:_duration*1];
    [self performSelector:@selector(animationThree)
               withObject:nil
               afterDelay:_duration *2];
    [self performSelector:@selector(showWord)
               withObject:nil
               afterDelay:_duration *1.5];
    [self performSelector:@selector(load)
               withObject:nil
               afterDelay:_duration * 4.0];
}

- (void)load
{
    [self.one removeFromSuperview];
    [self.two removeFromSuperview];
    [self.three removeFromSuperview];
    [self.word removeFromSuperview];
    [_splashView removeFromSuperview];
    
    HYDMainTabBarController *tabBarVC = [[HYDMainTabBarController alloc] init];
    self.window.rootViewController = tabBarVC;
}


- (void) shakeToShow:(UIImageView *)aView withDuration:(CGFloat)duration{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
    
}


- (void)animationOne
{
    [_splashView addSubview:_one];
    [self shakeToShow:_one withDuration:_duration];
}
- (void)animationTwo
{
    [_splashView addSubview:_two];
    [self shakeToShow:_two withDuration:_duration];
}
- (void)animationThree
{
    [_splashView addSubview:_three];
    [self shakeToShow:_three withDuration:_duration];
}


-(void)showWord
{
    
    [_splashView addSubview:_word];
    [_splashView addSubview:_logo];
    
    _word.alpha = 0.0;
    _logo.alpha = 0.0;
    [UIView animateWithDuration:_duration*2.5 delay:0.0f options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         _word.alpha = 1.0;
         _logo.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         // 完成后执行code
         //   [NSThread sleepForTimeInterval:1.0f];
         
     }
     ];
}


@end
