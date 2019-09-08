//
//  HYDNearbyDrugStoreVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/6/2.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNearbyDrugStoreVC.h"
#import "HYDNearbyDrugStoreView.h"
#import "HYDNearbyDrugStroeModel.h"
#import "CustomAnnotationView.h"

@interface HYDNearbyDrugStoreVC ()<MAMapViewDelegate>

@property (nonatomic,strong) HYDNearbyDrugStoreView *drugStroeView;
@property (nonatomic,strong) MAPointAnnotation *pointAnn;
@property (nonatomic,strong) HYDNearbyDrugStroeModel *model;

@end

@implementation HYDNearbyDrugStoreVC

- (void)loadView {
    [super loadView];
    
    self.drugStroeView = [[HYDNearbyDrugStoreView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _drugStroeView;
    _drugStroeView.mapView.showsUserLocation = YES;
    _drugStroeView.mapView.centerCoordinate = _drugStroeView.mapView.userLocation.coordinate;
    _drugStroeView.mapView.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self p_requestData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_drugStroeView.mapView setZoomLevel:13.f animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_drugStroeView.mapView clearDisk];
    
}


- (void) p_setupFetures {
    
    NSString *imgString = [NSString stringWithFormat:
                           @"http://tnfs.tngou.net/img%@",_model.img];
    [_drugStroeView.iconImageView sd_setImageWithURL:[NSURL URLWithString:imgString]
                                    placeholderImage:[UIImage imageNamed:@"logo_button"]];
    
    self.title = @"药店详情";
    _drugStroeView.nameLabel.text = _model.name;
    _drugStroeView.addressLabel.text = _model.address;
    _drugStroeView.businessLabel.text = _model.business;
    if (!_model.tel) {
        _drugStroeView.telButton.hidden = YES;
    }else
        [_drugStroeView.telButton setTitle:_model.tel
                                  forState:(UIControlStateNormal)];
    if (!(_drugStroeView.telButton.titleLabel.text.length > 6)) {
        _drugStroeView.telButton.hidden = YES;
    }
    
    [_drugStroeView.telButton addTarget:self
                                 action:@selector(telButtonAct:)
                       forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void) telButtonAct:(UIButton *)sender {
    
    NSString *str = @"";
   
    NSArray *array = [sender.titleLabel.text componentsSeparatedByString:@";"];
    str = [array firstObject];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",str]];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) p_requestData {
    
    self.model = [[HYDNearbyDrugStroeModel alloc]init];
    NSString *httpArg = [NSString stringWithFormat:@"id=%@",_id];
    NSString *urlString = [[NSString alloc]initWithFormat: @"%@?%@", HYDNEARBYTIANGOUDRUGSTORESHOW, httpArg];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:TNGOU_APIKEY forHTTPHeaderField:@"apikey"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"text/xml"] forHTTPHeaderField:@"Content-Type"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dictionary = [NSDictionary dictionary];
            dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                         options:NSJSONReadingMutableContainers |
                          NSJSONReadingMutableLeaves error:nil];
            
            if (dictionary)
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_model setValuesForKeysWithDictionary:dictionary];
                    if ([_model.tel rangeOfString:@","].location != NSNotFound ) {
                        NSArray *array = [_model.tel componentsSeparatedByString:@","];
                        _model.tel = [array firstObject];
                    }
                    [self p_setupFetures];
                    [self p_setupAnnotation];
                });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
    });
}


- (void) p_setupAnnotation {
    
    self.pointAnn = [[MAPointAnnotation alloc]init];
    _pointAnn.coordinate = CLLocationCoordinate2DMake([_model.y floatValue],
                                                      [_model.x floatValue]);
    [_drugStroeView.mapView addAnnotation:_pointAnn];
    
}

#pragma mark 代理方法<MAMapViewDelegate> 设置标注样式
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
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
        /**************** 设置为 NO,用以调用自定义的 calloutView ****************/
        annotationView.canShowCallout = NO;
        /**************** 设置中心点偏移,使得标注底部中间点成为经纬度对应点 ****************/
        annotationView.centerOffset = CGPointMake(0, -18); return annotationView;
    }
    
    if ([annotation isKindOfClass:[MAUserLocation class]]){
        /*
         MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
         pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
         pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
         pre.image = [UIImage imageNamed:@"loc_selected"];
         pre.lineWidth = 3;
         pre.lineDashPattern = @[@6, @3];
         [self.hospitalView.mapView updateUserLocationRepresentation:pre];
         */
    }
    return nil;
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        [_drugStroeView.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    }
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_drugStroeView.mapView clearDisk];
    
}

@end
