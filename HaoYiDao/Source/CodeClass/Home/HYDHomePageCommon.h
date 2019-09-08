//
//  HYDKnowledgeCommon.h
//  HaoYiDao
//
//  Created by Sprixin on 16/6/1.
//  Copyright © 2016年 cape. All rights reserved.
//

#ifndef HYDKnowledgeCommon_h
#define HYDKnowledgeCommon_h

#import "HYDHomeClassifyModel.h"
#import "UIView+RGSize.h"

#import "HYDHomeClassifyCell.h"
#import "HYDHomeClassifyModel.h"
#import "HYDHomeThemeModel.h"


#define HYDTIANGOULIST @"http://apis.baidu.com/tngou/lore/list" // 列表
#define HYDTIANGOUNEWS @"http://apis.baidu.com/tngou/lore/news" // 更新
#define HYDTIANGOUSHOW @"http://apis.baidu.com/tngou/lore/show" // 详情
#define HYDTIANGOUCLASSIFY @"http://apis.baidu.com/tngou/lore/classify" // 分类

// 保存用药管理
#define HOME_MEDICATIONS_INFO @"MEDICATIONSAVEFLAG"
// 主题
#define topicListlUrl @"http://dxy.com/app/i/columns/special/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&deviceName=cape&hardName=iPhone&items_per_page=10&mc=5332bbdfe68abac21905628602e318955c07eb61&page_index=1&vc=3.7.1&vs=8.3"

#define topicDetiallUrl @"http://dxy.com/app/i/columns/article/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&deviceName=cape&hardName=iPhone&items_per_page=10&mc=5332bbdfe68abac21905628602e318955c07eb61&order=publishTime&page_index=1&special_id="

#define TOPICDETIALINFO_URL @"http://dxy.com/app/i/columns/article/single?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&deviceName=cape&hardName=iPhone&id=%@"


#define topicListRefreshUrl @"http://dxy.com/app/i/columns/special/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&deviceName=cape&hardName=iPhone&items_per_page=10&mc=5332bbdfe68abac21905628602e318955c07eb61&page_index=%d&vc=3.7.1&vs=8.3"

// Theme

#define HOME_THEME_SECTION_URL @"http://api.lkhealth.net/index.php?r=h5/activity/section&os=h5&version=v1.0.1&sectionId=%@"
#define HOME_THEME_CLASS_URL @"http://api.lkhealth.net/index.php?r=h5/activity/moreInfo&os=h5&version=v1.0.1&classId=%@"
#define HOME_THEME_INFO_URL @"http://phone.lkhealth.net/ydzx/business/apppage/newsdetail.html?dataid=%@"

#define HOME_CLASSIFY_CLASSLIST_URL @"http://api.lkhealth.net/index.php?r=find/findDrugClassList&classId=%@"
#define HOME_CLASSIFY_KOUDAI_URL @"http://api.lkhealth.net/index.php?r=drug/medicaltool"

#define HOME_CLASSIFY_RAREDISEASE_URL @"http://api.lkhealth.net/index.php?r=drug/rareDisease"

// classify diseaseid
#define HOME_CLASSIFY_DESEASE @"http://api.lkhealth.net/index.php?r=find/Disease&diseaseId=%@"
#define HOME_CLASSIFY_DESEASEINFO @"http://phone.lkhealth.net/ydzx/business/apppage/newDiseaseInfo.html?diseaseid=%@"
#define HOME_CLASSIFY_DESEASEINFO_DRUGS @"http://api.lkhealth.net/index.php?r=drug/getmoredrugwithdiseaselist&diseaseId=%@&start=0&rows=20"
#define HOME_CLASSIFY_DRUG @"http://phone.lkhealth.net/ydzx/business/apppage/druginfo.html?&drugid=%@"

// 体检
#define HOME_PHYSICAL_LIST @"http://api.lkhealth.net/index.php?r=drug/medicaltool"
#define HOME_PHTSICAL_TEST @"http://phone.lkhealth.net/ydzx/business/tijie/index.php?quiz_id=%@"

// 罕见病
#define HOME_RAREDISEASR_LIST @"http://api.lkhealth.net/index.php?r=drug/rareDisease"

#define unotcStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_prescription.png"
#define otcStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_otc.png"
#define zhongyaoStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_chinesemade.png"
#define xiyaoStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_western.png"

// 生活贴士
#define HYD_LIFT_TIPS @"http://gwc.lkhealth.net/index.php?r=article/moreRecommendArticleList&rows=%d&start=%d"
#define HYD_LIFE_TIPS_INFO @"http://phone.lkhealth.net/ydzx/business/activities/quanzishen/index.html?articleId=%@"

#endif /* HYDKnowledgeCommon_h */
