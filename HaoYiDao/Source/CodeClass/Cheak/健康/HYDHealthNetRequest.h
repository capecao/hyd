//
//  HYDHealthNetRequest.h
//  HaoYiDao
//
//  Created by capecao on 2017/4/25.
//  Copyright © 2017年 cape. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestBlock) (id result);
typedef void(^ErrorBlock) (id error);

@interface HYDHealthNetRequest : NSObject

+ (instancetype) shareInstance;

@property (nonatomic,copy) RequestBlock Block;
@property (nonatomic,copy) ErrorBlock error;

- (void) netRequestWithParameter:(NSString *)parameter
                          Method:(NSString *)method
                           Block:(RequestBlock)block
                           Error:(ErrorBlock)error;
@end
