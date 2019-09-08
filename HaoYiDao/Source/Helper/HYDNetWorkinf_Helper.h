//
//  HYDNetWorkinf_Helper.h
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDNetWorkinf_Helper : NSObject

+ (HYDNetWorkinf_Helper *)shareInstance;
- (id) netRequestWith:(NSString *)url;

@end
