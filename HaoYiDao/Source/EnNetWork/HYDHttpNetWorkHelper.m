//
//  HYDHttpNetWorkHelper.m
//  HaoYiDao
//
//  Created by capecao on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHttpNetWorkHelper.h"

static HYDHttpNetWorkHelper *helper = nil;
@implementation HYDHttpNetWorkHelper

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[HYDHttpNetWorkHelper alloc]init];
        
    });
    
    return helper;
}

- (NSDictionary *)requestWithUrlString:(NSString *)urlString {
    
    __block NSDictionary *dictionary = [NSDictionary new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers |
                      NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"keys of dictionary:%@",[dictionary allKeys]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"request Error: %@",error);
    }];
    
    return dictionary;

}

@end
