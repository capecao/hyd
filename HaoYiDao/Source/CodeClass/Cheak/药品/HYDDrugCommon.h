//
//  HYDDrugCommon.h
//  HaoYiDao
//
//  Created by Sprixin on 16/5/27.
//  Copyright © 2016年 cape. All rights reserved.
//

#ifndef HYDDrugCommon_h
#define HYDDrugCommon_h

#import "PGCategoryView.h"
#import "HYDDrugCommon.h"

// 药品大全

#define urlDrugListThird @"http://api.lkhealth.net/index.php?r=drug/getdruglistbycalss&classId="

#define unotcStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_prescription.png"

#define otcStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_otc.png"

#define zhongyaoStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_chinesemade.png"

#define xiyaoStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_western.png"

#define drugDetailUrl @"http://phone.lkhealth.net/ydzx/business/apppage/druginfo.html?&drugid="

#define healthNewsdetailUrl @"http://dxy.com/app/i/columns/article/single?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&deviceName=cape&hardName=iPhone&id="

#define healthNewslastUrl @"&mc=5332bbdfe68abac21905628602e318955c07eb61&vc=3.7.1&vs=8.3"

#define scrollPicUrl @"http://phone.lkhealth.net/ydzx/business/apppage/newsdetail.html?&dataid="

// 检查项目

#define examinListUrl_1 @"http://api.lkhealth.net/index.php?r=news/assayfirst"
#define examinListUrl_2 @"http://api.lkhealth.net/index.php?r=news/assaysecond&dataId="

#define urlTestList @"http://api.lkhealth.net/index.php?r=news/assayfirst"
#define CHECKINFO_URL @"http://phone.lkhealth.net/ydzx/business/apppage/assaydetail.html?&dataid=%@"

// 药品大全

#define UrldrugFirst @"http://api.lkhealth.net/index.php?r=drug/getdrugclassify"
#define HYD_DRUGLIST_DRUG @"http://phone.lkhealth.net/ydzx/business/apppage/druginfo.html?&drugid=%@"

#endif /* HYDDrugCommon_h */
