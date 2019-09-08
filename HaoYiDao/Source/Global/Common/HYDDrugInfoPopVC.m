//
//  HYDSelfExDrugInfoPopVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/31.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDDrugInfoPopVC.h"
#import "CustomTransition.h"
#import "CustomPresentation.h"

@interface HYDDrugInfoPopVC ()<UIViewControllerTransitioningDelegate>
{
    UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
    CGFloat percent;
    CGFloat width;
    CGFloat height;
}
@end

@implementation HYDDrugInfoPopVC

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = self;
        
    }
    return self;
}


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
    [self.view addGestureRecognizer:pan];
    [self p_setupView];
}

- (void) p_setupView {
    
    width = self.view.bounds.size.width * .9 - 10;
    height = [self getCommentHeight:_introduce];
    
    
    if ([self.view viewWithTag:10001]) {
        [[self.view viewWithTag:10001] removeFromSuperview];
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * .05,
                                                           self.view.centerY - height / 2 - 30,
                                                           self.view.bounds.size.width * .9,
                                                           height + 60)];
    
    view.backgroundColor = HYD_themeColor;
    view.layer.cornerRadius = 5;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 1;
    view.layer.masksToBounds = YES;
    view.tag = 10001;
    [self.view addSubview:view];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, view.bounds.size.width - 60, 30)];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.numberOfLines = 0;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:16.f];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = _themeTitle;
    [view addSubview:titleLab];

    UIButton *cancelBt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    cancelBt.frame = CGRectMake(view.bounds.size.width - 30, 5, 20, 20);
    [cancelBt setBackgroundImage:[UIImage imageNamed:@"icon_close"]
                        forState:(UIControlStateNormal)];
    [cancelBt addTarget:self action:@selector(dismissClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:cancelBt];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(5,
                                                              CGRectGetMaxY(titleLab.frame) + 5,
                                                              width,
                                                              view.bounds.size.height - 35)];
    textView.text = _introduce;
    textView.backgroundColor = [UIColor clearColor];
//    textView.numberOfLines = 0;
    textView.scrollEnabled = NO;
    textView.textColor = [UIColor whiteColor];
    textView.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:15.f];
    [view addSubview:textView];
    
}

-(void)panGes:(UIPanGestureRecognizer *)gesture{
    CGFloat yOffset = [gesture translationInView:self.view].y;
    percent =  yOffset / 1800;
    //    percent = MAX(0, MIN(1, percent));
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        //这句必须加上！！
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        [percentDrivenInteractiveTransition updateInteractiveTransition:percent];
    }else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded){
        [percentDrivenInteractiveTransition finishInteractiveTransition];
        //        if (percent > 0.06) {
        //
        //
        //        }else{
        
        //            [percentDrivenInteractiveTransition cancelInteractiveTransition];
        
        //        }
        //这句也必须加上！！
        percentDrivenInteractiveTransition = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dismissClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - <UIViewControllerTransitioningDelegate>
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source
NS_AVAILABLE_IOS(8_0){
    CustomPresentation *presentation = [[CustomPresentation alloc]initWithPresentedViewController:presented
                                                                         presentingViewController:presenting];
    return presentation;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    CustomTransition * present = [[CustomTransition alloc]initWithBool:YES];
    return present;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    if (dismissed) {
        CustomTransition * present = [[CustomTransition alloc]initWithBool:NO];
        return present;
    }else{
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)
interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    if (animator) {
        return percentDrivenInteractiveTransition;
    }else{
        return nil;
    }
}


#pragma 自适应高度
- (CGFloat)getCommentHeight:(NSString *)string
{
    CGFloat H = [self getStringSize:string
                                   :CGSizeMake(width - 20, 10000)
                                   :[UIFont fontWithName:@"STHeitiSC-Medium" size:15.f]].height;
    return H;
}

- (CGSize) getStringSize:(NSString *)string :(CGSize)maxSize :(UIFont *)font {
    
    BOOL flag = [self stringIsEmpty:string];
    if (flag) {
        return CGSizeMake(0, 0);
    }
    
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

- (BOOL) stringIsEmpty:(NSString *)string {
    
    if ([string isKindOfClass:[NSNumber class]]) {
        NSNumber *stringNumber = (NSNumber *)string;
        string = [stringNumber stringValue];
    }
    if([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    if (string == nil) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] == 0) {
        return YES;
    }
    return NO;
}



@end
