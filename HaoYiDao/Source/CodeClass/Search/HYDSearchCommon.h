//
//  HYDSearchCommon.h
//  HaoYiDao
//
//  Created by capecao on 16/9/9.
//  Copyright © 2016年 cape. All rights reserved.
//

#ifndef HYDSearchCommon_h
#define HYDSearchCommon_h

#import "HYDSearchBaseModel.h"
#import "HYDSearchResultModel.h"
#import "HYDSearchDrugCell.h"
#import "HYDSearchDiseaseCell.h"
#import "HYDSearchChannelCell.h"
#import "HYDHTMLWebVC.h"
#import "HYDDrugInfoPopVC.h"

#define HYDSEARCH_LENOVO_URLSTRING @"http://api.lkhealth.net/index.php?r=news/lenovoword&keyword=%@"
#define HYDSEARCH_REQUEST_URLSTRING @"http://api.lkhealth.net/index.php?r=user/globalSearchResultNew&keyword=%@"

#define unotcStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_prescription.png"

#define otcStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_otc.png"

#define zhongyaoStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_chinesemade.png"

#define xiyaoStr @"http://phone.lkhealth.net/ydzx/business/apppage/img/tag_drugtype_western.png"


#define HYD_SEARCH_CHANNEL @"http://phone.lkhealth.net/ydzx/business/apppage/newsdetail.html?dataid=%@"
#define HYD_SEARCH_DISEASE @"http://phone.lkhealth.net/ydzx/business/apppage/newDiseaseInfo.html?diseaseid=%@"
#define HYD_SEARCH_DRUG @"http://phone.lkhealth.net/ydzx/business/apppage/druginfo.html?&drugid=%@"

#define HYD_SEARCH_MORERESULT @"http://api.lkhealth.net/index.php?r=user/globalSearchResultMore&keyword=%@&type=%@&start=%d&rows=%d"

#endif /* HYDSearchCommon_h */
