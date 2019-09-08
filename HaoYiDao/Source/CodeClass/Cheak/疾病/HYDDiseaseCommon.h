//
//  HYDDiseaseCommon.h
//  HaoYiDao
//
//  Created by Sprixin on 16/5/31.
//  Copyright © 2016年 cape. All rights reserved.
//

#ifndef HYDDiseaseCommon_h
#define HYDDiseaseCommon_h

#import "RESideMenu.h"

#define HYDAdministrativeListUrl @"http://api.lkhealth.net/index.php?r=drug/getcommondisease"
#define HYDDiseaseListUrlTYPE_1 @"http://api.lkhealth.net/index.php?r=drug/diseaseown&diseaseId=%@"
#define HYDDiseaseListUrlTYPE_2 @"http://api.lkhealth.net/index.php?r=drug/symptomown&symptomId=%@"
#define DISEASE_NEWS_INFO_URL @"http://phone.lkhealth.net/ydzx/business/apppage/newsdetail.html?dataid=%@"

#define HYDADMINISTRATIVENOTIFICATION @"HYDADMINISTRATIVENOTIFICATION"
#define HYDDISEASELIST_STANDAR0 @"HYDDISEASELIST_STANDAR0"

#endif /* HYDDiseaseCommon_h */
