//
//  HYDNetWorkinf_Helper.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNetWorkinf_Helper.h"
#import "AFNetworking.h"

@implementation HYDNetWorkinf_Helper

static HYDNetWorkinf_Helper *helper = nil;

+ (HYDNetWorkinf_Helper *)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[HYDNetWorkinf_Helper alloc]init];
    });
    return helper;
}


- (id) netRequestWith:(NSString *)url {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __block NSDictionary *dic = [NSDictionary new];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];

                
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    return dic;
}
@end
