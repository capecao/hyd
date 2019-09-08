//
//  HYDDiseaseInfoModel.h
//  HaoYiDao
//
//  Created by Sprixin on 16/6/1.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDDiseaseInfoModel : NSObject

@property(nonatomic,copy)NSString *infoId;
@property(nonatomic,copy)NSString *infoTitle;
@property(nonatomic,copy)NSString *infoLogo;
@property(nonatomic,copy)NSString *infoContent;
@property(nonatomic,copy)NSString *infoType;

@property (nonatomic,copy) NSString *drugName;
@property (nonatomic,copy) NSString *drugPic;
@property (nonatomic,copy) NSString *promotionInfo;

@end
