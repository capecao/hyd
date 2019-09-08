//
//  HYDHttpNetWorkHelper.h
//  HaoYiDao
//
//  Created by capecao on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDHttpNetWorkHelper : NSObject

+ (instancetype) shareInstance;
- (NSDictionary *) requestWithUrlString:(NSString *)urlString;

@end
