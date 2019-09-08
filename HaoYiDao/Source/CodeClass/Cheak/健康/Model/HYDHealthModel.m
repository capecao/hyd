//
//  HYDHealthModel.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/25.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "HYDHealthModel.h"

@implementation HYDHealthModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    //手动处理description
    if ([key isEqualToString: @"description"]) {
        _des = value;
    }else if ([key isEqualToString: @"id"]) {
        _Id = value;
    }
    else{
        //调用父类方法，保证其他属性正常加载
        [super setValue:value forKey:key];
    }
}

@end
