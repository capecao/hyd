//
//  HYDSelfExamationCommon.h
//  HaoYiDao
//
//  Created by Sprixin on 16/5/30.
//  Copyright © 2016年 cape. All rights reserved.
//

#import <Foundation/NSString.h>

#ifndef HYDSelfExamationCommon_h
#define HYDSelfExamationCommon_h

#define SelfExamationTopicListUrl @"http://api.lkhealth.net/index.php?r=drug/checksymptomlist&gender=%@&age=&partName=%@"
#define SelfExamationDetailListUrl @"http://api.lkhealth.net/index.php?r=drug/checkdiseaselist&symptomId=%@&gender=%@&age=30"

#define SelfExDetailInfotUrl @"http://api.lkhealth.net/index.php?r=drug/diseaseown&diseaseId=%@"

#define SELFEX_NEWS_INFO_URL @"http://phone.lkhealth.net/ydzx/business/apppage/newsdetail.html?dataid=%@"

#endif /* HYDSelfExamationCommon_h */
