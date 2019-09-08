//
//  HYDHomeRareDiseaseModel.h
//  HaoYiDao
//
//  Created by Sprixin on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDHomeRareDiseaseModel : NSObject

@property (nonatomic,copy) NSString *dataId;
@property (nonatomic,copy) NSString *dataName;
@property (nonatomic,copy) NSString *sort;
@property (nonatomic,copy) NSString *isWeiHu;
@property (nonatomic,strong) NSArray *twoType;
@property (nonatomic,copy) NSString *deseaseIntro;

@end
