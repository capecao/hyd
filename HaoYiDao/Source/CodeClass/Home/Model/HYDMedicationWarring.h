//
//  JYIsAutoWarrings.h
//  JYFSKElectricity
//
//  Created by Sprixin on 16/7/19.
//  Copyright © 2016年 sprixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDMedicationWarring : NSObject

/********************
 **********************
 ************
 提示：是否自动报警请求集团电站下的故障信息
 默认：自动报警
 ************
 **********************
 ********************/

+ (instancetype) shareInstance;
- (void) IsRequestWarrings;

@end
