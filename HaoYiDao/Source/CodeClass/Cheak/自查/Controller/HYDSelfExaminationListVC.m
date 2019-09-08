//
//  HYDSelfExaminationListVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDSelfExaminationListVC.h"
#import "HYDSelfExaminationView.h"
#import "HYDSelfExTopicListVC.h"

@interface HYDSelfExaminationListVC ()
{
    BOOL sexFlag;
    BOOL aroundFlag;
    NSString *gender;
}
@property (nonatomic,strong) HYDSelfExaminationView *selfExamineView;
@property (nonatomic,strong) NSArray *names;

@end

@implementation HYDSelfExaminationListVC

- (void)loadView {
    [super loadView];
    
    self.selfExamineView = [[HYDSelfExaminationView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _selfExamineView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"疾病自查";
    
    self.names = @[@"眼部",@"鼻",@"喉咙",@"耳",@"牙齿",@"口腔",@"头部",@"面部",@"颈部",@"肩部",@"上肢",
                   @"肛门",@"手部",@"生殖器部位",@"骨盆",@"皮肤",@"下肢",@"足部",@"胸部",@"腹部"];
    gender = @"1";
    
    [self p_setupFeatures];
    
}

- (void) p_setupFeatures {
    
    for (int i = 0; i < 20; i ++) {
        UIButton *button = [_selfExamineView viewWithTag:(10100 + i)];
        [button addTarget:self action:@selector(bodyBtAction:)
         forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    [_selfExamineView.sexBt addTarget:self action:@selector(sexBtAct:)
                     forControlEvents:(UIControlEventTouchUpInside)];
    
    [_selfExamineView.aroundBt addTarget:self action:@selector(aroundBtAct:)
                        forControlEvents:(UIControlEventTouchUpInside)];

}

#pragma mark click event
- (void) bodyBtAction:(UIButton *)sender {
    
    HYDSelfExTopicListVC *topicVC = [[HYDSelfExTopicListVC alloc]init];
    topicVC.gender = gender;
    NSInteger index = sender.tag - 10100;
    topicVC.bodyKey = _names[index];
    [self.navigationController pushViewController:topicVC animated:YES];
}

- (void) sexBtAct:(UIButton *)sender {
    
    if (sexFlag == NO) {
        _selfExamineView.sexImageView.image = [UIImage imageNamed:@"female"];
        gender = @"0";
        sexFlag = YES;
    }else {
        _selfExamineView.sexImageView.image = [UIImage imageNamed:@"male"];
        gender = @"1";
        sexFlag = NO;
    }
}

- (void) aroundBtAct:(UIButton *)sender {
    
    if (aroundFlag == NO) {
        self.names = @[@"眼部",@"鼻",@"喉咙",@"耳",@"牙齿",@"口腔",@"头部",@"面部",@"颈部",@"肩部",
                       @"上肢",@"肛门",@"手部",@"臀部",@"骨盆",@"皮肤",@"下肢",@"足部",@"背部",@"腰部"];
        
        [_selfExamineView.body113Bt setBackgroundImage:[UIImage imageNamed:@"122"] forState:(UIControlStateNormal)];
        [_selfExamineView.body118Bt setBackgroundImage:[UIImage imageNamed:@"120"] forState:(UIControlStateNormal)];
        [_selfExamineView.body119Bt setBackgroundImage:[UIImage imageNamed:@"121"] forState:(UIControlStateNormal)];
        aroundFlag = YES;
    }else {
        self.names = @[@"眼部",@"鼻",@"喉咙",@"耳",@"牙齿",@"口腔",@"头部",@"面部",@"颈部",@"肩部",
                       @"上肢",@"肛门",@"手部",@"生殖器部位",@"骨盆",@"皮肤",@"下肢",@"足部",@"胸部",@"腹部"];
        
        [_selfExamineView.body113Bt setBackgroundImage:[UIImage imageNamed:@"113"] forState:(UIControlStateNormal)];
        [_selfExamineView.body118Bt setBackgroundImage:[UIImage imageNamed:@"118"] forState:(UIControlStateNormal)];
        [_selfExamineView.body119Bt setBackgroundImage:[UIImage imageNamed:@"119"] forState:(UIControlStateNormal)];
        
        aroundFlag = NO;
    }
    
}


@end
