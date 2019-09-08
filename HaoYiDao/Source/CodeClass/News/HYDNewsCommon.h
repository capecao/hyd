//
//  HYDNewsCommon.h
//  HaoYiDao
//
//  Created by Sprixin on 16/5/27.
//  Copyright © 2016年 cape. All rights reserved.
//

#ifndef HYDNewsCommon_h
#define HYDNewsCommon_h

#define NEWS_LOAD_DATA_NOTIFICATION @"NEWS_LOAD_DATA_NOTIFICATION"

// 点击
#define itemClickedUrl @"http://phone.lkhealth.net/ydzx/business/apppage/newsdetail.html?&dataid="

#define topicClickedUrl @"http://dxy.com/app/i/columns/article/single?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&deviceName=cape&hardName=iPhone&id="
#define topicClickedlastStr @"&mc=5332bbdfe68abac21905628602e318955c07eb61&vc=3.7.1&vs=8.3"

#pragma mark 轮播
#define NEWS_LUNBO_LIST @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=%@&channelType=0"
#pragma mark 资讯list
#define NEWS_LIST @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=%@&channelType=0&start=0&rows=15"


#define HYD_NEWS_CATEGORY_LISTURLSTRING @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=%@&channelType=%@&start=%d&rows=%d"
#define HYD_NEWS_CATAEGPRY_LISTCIRCLE @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=%@&channelType=%@"
//1.都市健康人
#define duShijiankangren1 @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=8&channelType=1&start=0&rows=15"
#define duShijiankangren0 @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=8&channelType=1"

//2.育婴护理
#define yuYinghuli1 @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=44&channelType=0&start=0&rows=15"
#define yuYinghuli0 @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=44&channelType=0"

//3.医药指南
#define yiYaozhinan1 @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=8&channelType=0&start=0&rows=15"
#define yiYaozhinan0 @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=8&channelType=0"

//4.运动饮食
#define yunDongyingshi1 @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=28&channelType=0&start=0&rows=15"
#define yunDongyingshi0 @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=28&channelType=0"

//5.留言粉碎机
#define liuYanfengsuiji1 @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=47&channelType=0&start=0&rows=15"
#define liuYanfengsuiji0 @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=47&channelType=0"

//6.养生保健
#define yangShengbaojian1 @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=32&channelType=0&start=0&rows=15"
#define yangShengbaojian0 @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=32&channelType=0"

//7.两性知识
#define liangXing1 @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=45&channelType=0&start=0&rows=15"
#define liangXing0 @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=45&channelType=0"

//8.护眼专栏
#define huYanzhuanlan1 @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=58&channelType=0&start=0&rows=15"
#define huYanzhuanlan0 @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=58&channelType=0"

//9.头条
#define HYD_NEWS_FOCUSE @"http://api.lkhealth.net/index.php?r=news/topnewslist&start=%d&rows=%d"
#define reDian0 @"http://api.lkhealth.net/index.php?r=news/toplbtlist&lng=123.007758&os=ios&lat=41.118741&city=%E9%9E%8D%E5%B1%B1&ver=5.0.4&appId=13&channel="

//10.曝光台
#define baoGuangtai1 @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=31&channelType=0&start=0&rows=15"
#define baoGuangtai0 @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=31&channelType=0"



//12.祝您健康
#define zhuNinjiankang1 @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=12&channelType=1&start=0&rows=15"
#define zhuNinjiankang0 @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=12&channelType=1"

//15.家庭用药
#define jiaTingyongyao1 @"http://api.lkhealth.net/index.php?r=news/channelinfolist&channelId=17&channelType=1&start=0&rows=15"
#define jiaTingyongyao0 @"http://api.lkhealth.net/index.php?r=news/channelcarousel&channelId=17&channelType=1"

// 主题
#define topicHttpUrl @"http://dxy.com/app/i/columns/special/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&deviceName=cape&hardName=iPhone&items_per_page=10&mc=5332bbdfe68abac21905628602e318955c07eb61&page_index=%ld&vc=3.7.1&vs=8.3"

#endif /* HYDNewsCommon_h */
