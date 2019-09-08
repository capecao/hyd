//
//  HYDNearbyListVC.h
//  HaoYiDao
//
//  Created by Sprixin on 16/6/2.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYDNearbyListVC : UIViewController

@property (nonatomic,strong) NSMutableArray *lists;
@property (nonatomic,copy) NSString *type; // 医院/药店
@property (nonatomic,copy) NSString *latitude; // 医院/药店 维度
@property (nonatomic,copy) NSString *longitude; // 医院/药店 经度

@end
