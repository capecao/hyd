//
//  HYDHealthNetRequest.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/25.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "HYDHealthNetRequest.h"
#import "HYDHealthCommon.h"

static HYDHealthNetRequest *request;

@implementation HYDHealthNetRequest

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[HYDHealthNetRequest alloc]init];
    });
    
    [ProgressHUD show:@"正在加载..." Interaction:NO];
    
    return request;
}


/**
 请求
 
 @param json json字符
 @param method 方法名
 @param block 请求成功的block
 @param error 失败的error
 */
- (void) netRequestWithParameter:(NSString *)parameter
                          Method:(NSString *)method
                           Block:(RequestBlock)block
                           Error:(ErrorBlock)error {
    
    AFHTTPSessionManager *manager = [self getAFHTTPSessionManager];
    
    NSString *string = [NSString stringWithFormat:@"%@/%@",HYDHEALTH_HOST,method];
    if (parameter.length) {
        NSString *str = [NSString stringWithFormat:@"?%@",parameter];
        string = [string stringByAppendingString:str];
    }

    __weak typeof(self) weakSelf = self;
    
    weakSelf.Block = block;
    weakSelf.error = error;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager GET:[self urlString:string] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                       options:NSJSONReadingMutableContainers |
                                        NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                                         error:nil];
            HYDHealthModel *Model = [HYDHealthModel new];
            [Model setValuesForKeysWithDictionary:dictionary];
            
            if ([dictionary allKeys].count)
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [ProgressHUD dismiss];
                    
                    if (Model.status)
                        
                        weakSelf.Block(dictionary);
                    
                    else
                        weakSelf.error(error);
                });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [ProgressHUD showError:@"网络故障，请检查设置"];
        }];
    });
}


- (AFHTTPSessionManager *) getAFHTTPSessionManager {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =
    [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text／html",@"text/plain"]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /*utf8,ASCII转码*/
    return manager;
}

- (NSString *) urlString:(NSString *)string {
    
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    string = [string stringByAddingPercentEncodingWithAllowedCharacters:
              [NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    return string;
}

@end
