//
//  YSLItemMangerHelp.m
//  HaoYiDao
//
//  Created by capecao on 16/9/22.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "YSLNewsMenuManger.h"

static YSLNewsMenuManger *manger = nil;

@implementation YSLNewsMenuManger

+ (instancetype) shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[YSLNewsMenuManger alloc]init];
    });
    
    return manger;
}

- (void) addNewsMenuModel:(NewsMenuModel *)model {

    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    NSString *title = [NSString stringWithFormat:@"添加 %@",model.channelName];
    [ProgressHUD showSuccess:title];
}

- (void)removeNewsMenuModel:(NewsMenuModel *)model {
    /*删除数据*/
    if ([model MR_deleteEntity]){
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (NSArray *)findAll {
    
    NSArray *array = [NewsMenuModel MR_findAll];
    return array;
}

@end
