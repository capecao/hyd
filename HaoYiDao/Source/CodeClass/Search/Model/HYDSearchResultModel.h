//
//  HYDSearchResultModel.h
//  HaoYiDao
//
//  Created by capecao on 16/9/10.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDSearchResultModel : NSObject

@property (nonatomic,copy) NSString *assoc_word;
@property (nonatomic,copy) NSString *group_s;

@property (nonatomic,copy) NSString *drugPic;
@property (nonatomic,copy) NSString *drugId;
@property (nonatomic,copy) NSString *drugName;
@property (nonatomic,copy) NSString *pack;
@property (nonatomic,copy) NSString *companyName;
@property (nonatomic,copy) NSString *indication;
@property (nonatomic,copy) NSString *xiyao;
@property (nonatomic,copy) NSString *OTC;

@property(nonatomic,copy)NSString *deseaseName;
@property(nonatomic,copy)NSString *deseaseIntro;
@property(nonatomic,copy)NSString *solrId;
@property(nonatomic,copy)NSString *solrTypeId;
@property(nonatomic,copy)NSString *deseaseId;
@property (nonatomic,copy) NSString *isWeiHu;

@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *likeCount;
@property(nonatomic,copy)NSString *dataTitle;
@property(nonatomic,copy)NSString *dataId;
@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *symptomName;
@property(nonatomic,copy)NSString *symptomId;
@property(nonatomic,copy)NSString *symptomIntro;

@end
