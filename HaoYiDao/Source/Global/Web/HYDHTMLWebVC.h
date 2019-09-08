//
//  HYDHomeClassifyWebVC.h
//  HaoYiDao
//
//  Created by Sprixin on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int64_t,WebLoad_TYPE) {
    LoadTypeNone = 0,
    LoadTypeDingxiangyuan = 1,
    LoadTypeTiangou = 2,
    LoadTypeNormalUrl = 3,
    LoadTypeString = 4,
} ;

@interface HYDHTMLWebVC : UIViewController

@property (nonatomic,copy) NSString *urlString;
@property (nonatomic,assign) WebLoad_TYPE Load_Type;
@property (nonatomic,copy) NSString *htmlString;

@end
