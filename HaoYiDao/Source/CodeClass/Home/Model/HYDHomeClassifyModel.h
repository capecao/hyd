//
//  HYDHomeClassifyModel.h
//  HaoYiDao
//
//  Created by capecao on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDHomeClassifyModel : NSObject

@property (nonatomic,copy) NSString *classId;
@property (nonatomic,copy) NSString *className;
@property (nonatomic,strong) NSArray *deseaseList;

@property (nonatomic,copy) NSString *deseaseId;
@property (nonatomic,copy) NSString *deseaseName;
@property (nonatomic,copy) NSString *sameid;
@property (nonatomic,copy) NSString *isWeiHu;

@property (nonatomic,copy) NSString *deseaseIntro;

@property (nonatomic,copy) NSString *articleId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *isTop;
@property (nonatomic,strong) NSArray *articleTags;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *articleUrl;

@end
