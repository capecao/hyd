//
//  HYDCategoryVC.h
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYDNewsCategoryVC : UIViewController

@property (nonatomic,copy) NSString *channelType;
@property (nonatomic,copy) NSString *channelId;
- (void) p_requestImgsData;
- (void) p_requestNewsData:(NSString *)urlString;

@end
