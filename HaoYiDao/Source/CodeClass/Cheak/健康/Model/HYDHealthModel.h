//
//  HYDHealthModel.h
//  HaoYiDao
//
//  Created by capecao on 2017/4/25.
//  Copyright © 2017年 cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDHealthModel : NSObject
/*
 "description":"社会热点，健康资讯，综合健康资讯,生活热点新闻,社会热点新闻,社会热点查询,提供最新的健康资讯,社会热点新闻网",
 "id":6,
 "keywords":"社会热点",
 "name":"社会热点",
 "seq":1,
 "title":"社会热点"
 */
@property (nonatomic,assign) BOOL status;
@property (nonatomic,strong) NSArray *tngou;
@property (nonatomic,copy) NSString *total;

@property (nonatomic,copy) NSString *des;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *keywords;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *seq;
@property (nonatomic,copy) NSString *title;

/* 
 "fcount":0,
 "id":6988,
 "img":"/info/170106/72adb38ec07ea93cca49c60634da2e0d.jpg",
 "infoclass":6,
 "keywords":"职业病 电脑 白领 职业 鼠标 ",
 "rcount":0,
 "time":1483690203000,
 "title":"上班族警惕4种常见职业病 屏幕脸长时间面对电脑"
 */
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *infoclass;
@property (nonatomic,copy) NSString *rcount;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *summary;

@property (nonatomic,copy) NSString *message;

@end
