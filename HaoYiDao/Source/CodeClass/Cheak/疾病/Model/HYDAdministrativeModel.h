//
//  HYDAdministrativeModel.h
//  HaoYiDao
//
//  Created by Sprixin on 16/5/31.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDAdministrativeModel : NSObject

@property (nonatomic,copy) NSString *dataName;
@property (nonatomic,copy) NSString *dataId;
@property (nonatomic,strong) NSMutableArray *twoType;
@property (nonatomic,copy) NSString *dataType;

@end
