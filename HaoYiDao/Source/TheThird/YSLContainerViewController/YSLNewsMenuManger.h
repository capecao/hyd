//
//  YSLItemMangerHelp.h
//  HaoYiDao
//
//  Created by capecao on 16/9/22.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSLNewsMenuManger : NSObject

+ (instancetype) shareInstance;
- (NSArray *) findAll;

- (void) addNewsMenuModel:(NewsMenuModel *)model;
- (void) removeNewsMenuModel:(NewsMenuModel *)model;

@end
