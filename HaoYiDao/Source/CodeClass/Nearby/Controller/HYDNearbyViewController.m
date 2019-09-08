//
//  HYDNearbyViewController.m
//  HaoYiDao
//
//  Created by Sprixin on 16/5/26.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNearbyViewController.h"
#import "HYDNearbyView.h"
#import "HYDPointAnnotation.h"
#import "CustomAnnotationView.h"
#import "HYDNearby_briefModel.h"
#import "HYDNearbyListVC.h"
#import "HYDNearbyCommon.h"

@interface HYDNearbyViewController ()<MAMapViewDelegate>
{
    NSString *type;
    BOOL requestedFLAG;
}

@property (nonatomic,strong) HYDNearbyView *nearbyView;
@property (nonatomic,strong) UIImageView *annotationImageView; //着重标注
@property (nonatomic,strong) NSMutableArray *hospitalArray; //医院
@property (nonatomic,strong) NSMutableArray *pharmacyArray; //药店
@property (nonatomic,strong) MAUserLocation *userLocation; //定位坐标

@property (nonatomic,strong) NSMutableArray *hospitals; //医院标注
@property (nonatomic,strong) NSMutableArray *pharmacys; //药店标注

@property (nonatomic,strong) NSMutableArray *hospitalModels; //医院model
@property (nonatomic,strong) NSMutableArray *pharmacyModels; //药店model
@property (nonatomic,strong) NSMutableArray *briefArray; //存放model


@end

@implementation HYDNearbyViewController

- (void)loadView {
    [super loadView];
    
    self.nearbyView = [[HYDNearbyView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _nearbyView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupFeatures];

}

- (void) p_setupFeatures {
    
    type = @"0"; // 医院
    self.view.backgroundColor = [UIColor whiteColor];
    _nearbyView.mapView.delegate = self;
    
    [_nearbyView.segmentControl addTarget:self
                                   action:@selector(segmentAction:)
                         forControlEvents:(UIControlEventValueChanged)];
    
    NavItemView *navItemView2 = [[NavItemView alloc]initWithFrame:navFrame];
    [navItemView2.barButton setImage:[UIImage imageNamed:@"nav_list"]
                             forState:(UIControlStateNormal)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:navItemView2];
    UIBarButtonItem *negativeSpacer2 = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                        target:nil
                                        action:nil];
    
    negativeSpacer2.width = -negativeSpace;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer2, item2];
    [navItemView2.barButton addTarget:self
                               action:@selector(rightItemAction:)
                     forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_nearbyView.mapView setZoomLevel:12.f];
    
}

- (void) rightItemAction:(UIButton *)sender {
    
    HYDNearbyListVC *listVC = [[HYDNearbyListVC alloc] init];
    listVC.latitude = [NSString stringWithFormat:@"%f",_userLocation.location.coordinate.latitude];
    listVC.longitude = [NSString stringWithFormat:@"%f",_userLocation.location.coordinate.longitude];
    listVC.lists = _briefArray;
    listVC.type = type;
    [self presentViewController:[[HYDNavigationController alloc]initWithRootViewController:listVC] animated:YES completion:nil];
    
}

- (void) httpRequestWithHttpUrl:(NSString *)httpUrl{
    
    NSString *latitude = [NSString stringWithFormat:@"%f",_userLocation.location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",_userLocation.location.coordinate.longitude];
    NSString *httpArg = [NSString stringWithFormat:@"x=%@&y=%@&page=1&rows=30",longitude,latitude];
    NSString *urlString = [[NSString alloc]initWithFormat:@"%@?%@", httpUrl, httpArg];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    urlString = [urlString  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictionary = [NSDictionary dictionary];
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers |
                      NSJSONReadingMutableLeaves error:nil];
        
        if ([httpUrl isEqualToString:HYDNEARBYTIANGOUHOSPITAL]) {
            [self p_pickData:dictionary :0];
        }else if ([httpUrl isEqualToString:HYDNEARBYTIANGOUDRUGSTORE]){
            [self p_pickData:dictionary :1];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
    }];
}

- (void) p_pickData:(NSDictionary *)dictionary :(int)index{
    
    if (!requestedFLAG) {
        requestedFLAG = YES;
        NSArray *array = [dictionary valueForKey:@"tngou"];
        NSMutableArray *dataArray = [NSMutableArray array];
        
        if (array.count > 30) {
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 0; i < 30; i ++) {
                [arr addObject:array[i]];
            }
            array = [NSArray arrayWithArray:arr];
        }
        for (NSDictionary *dic in array) {
            
            HYDNearby_briefModel *model = [[HYDNearby_briefModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [dataArray addObject:model];
        }
        
        if (index == 0) {
            self.hospitals = [NSMutableArray array];
            self.hospitalModels = [NSMutableArray array];
            self.hospitalArray = [NSMutableArray arrayWithArray:dataArray];
            [self showtargetViewWithLocationArray:dataArray Annotations:_hospitals Models:_hospitalModels];
            [_nearbyView.mapView addAnnotations:_hospitals];
            
        }else if (index == 1) {
            
            self.pharmacys = [NSMutableArray array];
            self.pharmacyModels = [NSMutableArray array];
            self.pharmacyArray = [NSMutableArray arrayWithArray:dataArray];
            [self showtargetViewWithLocationArray:dataArray Annotations:_pharmacys Models:_pharmacyModels];
            [_nearbyView.mapView addAnnotations:_pharmacys];
        }
    }
}

#pragma mark 修改数据源
- (void) segmentAction:(UISegmentedControl *)sender {

    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            if (_hospitals.count > 0) {
                [_nearbyView.mapView removeAnnotations:_hospitals];
            }
            if (_pharmacys.count > 0) {
                [_nearbyView.mapView removeAnnotations:_pharmacys];
            }

            if (!(_hospitalArray.count > 0))
                [self httpRequestWithHttpUrl:HYDNEARBYTIANGOUHOSPITAL];
           
            self.briefArray = _hospitalModels;
            
            [_nearbyView.mapView addAnnotations:_hospitals];
            
            type = @"0";
        }
            break;
            
        case 1:
        {
            if (_hospitals.count > 0) {
                [_nearbyView.mapView removeAnnotations:_hospitals];
            }
            if (_pharmacys.count > 0) {
                [_nearbyView.mapView removeAnnotations:_pharmacys];
            }

            [_nearbyView.mapView removeAnnotations:_hospitals];

            if (!(_pharmacyArray.count > 0)){
                requestedFLAG = false;
                [self httpRequestWithHttpUrl:HYDNEARBYTIANGOUDRUGSTORE];
            }
            self.briefArray = _pharmacyModels;
            
            [_nearbyView.mapView addAnnotations:_pharmacys];
            
            type = @"1";
        }
            break;
        default:
            break;
    }
}

#pragma mark 添加标注
- (void) showtargetViewWithLocationArray:(NSArray *)dataArray
                                  Annotations:(NSMutableArray *)annotations
                                       Models:(NSMutableArray *)models {

    [annotations removeAllObjects];
    [models removeAllObjects];

    for (int i = 0; i < dataArray.count; i ++) {
        
        HYDNearby_briefModel *model = (HYDNearby_briefModel *)dataArray[i];
        
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([model.y floatValue],[model.x floatValue]);
        HYDPointAnnotation *annotationPoint = [[HYDPointAnnotation alloc]init];
        annotationPoint.coordinate = location;
        annotationPoint.tag = i + 1000;
        // 保存标注
        [annotations addObject:annotationPoint];
        
        //1.将两个经纬度点转成投影点
        
        MAMapPoint point1 = MAMapPointForCoordinate(location);
        MAMapPoint point2 = MAMapPointForCoordinate
        (CLLocationCoordinate2DMake(_userLocation.location.coordinate.latitude,
                                    _userLocation.location.coordinate.longitude));
        //2.计算距离
        CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
        model.distance = [NSString stringWithFormat:@"距离: %.2f km",distance / 1000];
        // 保存model
        [models addObject:model];
    }
    
    [_nearbyView.mapView removeAnnotations:annotations];
    
    self.briefArray = [NSMutableArray arrayWithArray:models];

}

#pragma marl 获取用户坐标
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        //        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        self.userLocation = userLocation;
        [_nearbyView.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
        
    }
    
    if (!(_hospitalArray.count > 0)) {
        
        // 先加载医院
        [self httpRequestWithHttpUrl:HYDNEARBYTIANGOUHOSPITAL];
    }
    
}

#pragma mark 代理方法<MAMapViewDelegate> 设置标注样式
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[HYDPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        CGPoint tempPoint = annotationView.center;
        CGRect tempRect;
        tempRect.origin = tempPoint;
        tempRect.size.width = tempRect.size.height = 32;
        annotationView.bounds = tempRect;
        
        annotationView.image = [UIImage imageNamed:@"loc_normal"];
        
        CGRect Rect1 = annotationView.frame;
        [UIView animateWithDuration:.8f animations:^{
            CGRect rect2 = CGRectMake(0, 200, CGRectGetWidth(Rect1), CGRectGetHeight(Rect1));
            annotationView.frame = rect2;
        }];
        annotationView.frame = Rect1;
        // 设置为 NO,用以调用自定义的 calloutView
        annotationView.canShowCallout = NO;
        // 设置中心点偏移,使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18); return annotationView;
    }
    
    if ([annotation isKindOfClass:[MAUserLocation class]]){
        
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"location.png"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6, @3];
        [self.nearbyView.mapView updateUserLocationRepresentation:pre];
    }
    
    
    return nil;
}

#pragma mark MAAnnotationView点击事件
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        CustomAnnotationView *customView = [[CustomAnnotationView alloc]init];
        customView = (CustomAnnotationView *)view;
        
        if ([customView.annotation isKindOfClass:[HYDPointAnnotation class]]) {
            
            HYDPointAnnotation *annotation = [[HYDPointAnnotation alloc]init];
            annotation = customView.annotation;
            NSInteger count = annotation.tag;
            
            HYDNearby_briefModel *model = _briefArray[count - 1000];
            
            customView.calloutView.briefView.nameLale.text = model.name;
            if (model.business.length > 0)
                customView.calloutView.briefView.introLabel.text = model.business;
            else
                customView.calloutView.briefView.introLabel.text =
                [NSString stringWithFormat:@"%@ %@",model.mtype,model.nature];
            
            customView.calloutView.briefView.countLabel.text =
            [NSString stringWithFormat:@"关注:\n%@",model.count];
            
            customView.calloutView.briefView.distanceLabel.text = model.distance;
            customView.calloutView.briefView.addressLabel.text = model.address;
            
            NSString *imgString = [NSString stringWithFormat:@"http://tnfs.tngou.net/img%@",model.img];
            
            [customView.calloutView.briefView.imgImageView
             sd_setImageWithURL:[NSURL URLWithString:imgString]
             placeholderImage:[UIImage imageNamed:@"logo_button"]];
            
        }
        
        // 点击时改变图标
        if (_annotationImageView) {
            [_annotationImageView removeFromSuperview];
        }
        self.annotationImageView = [[UIImageView alloc]initWithFrame:view.bounds];
        _annotationImageView.image = [UIImage imageNamed:@"loc_selected"];
        [view addSubview:_annotationImageView];
        
        [_nearbyView.mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
        
    }
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _nearbyView.mapView.mapType = MAMapTypeStandard;
}

@end
