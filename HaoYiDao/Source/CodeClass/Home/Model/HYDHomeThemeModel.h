//
//  HYDHomeThemeModel.h
//  HaoYiDao
//
//  Created by Sprixin on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDHomeThemeModel : NSObject

@property (nonatomic,copy) NSString *sectionId;
@property (nonatomic,strong) NSArray *sections;

@property (nonatomic,copy) NSString *classId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *segment1_title;
@property (nonatomic,copy) NSString *segment2_title;

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *upLineTime;


@end
