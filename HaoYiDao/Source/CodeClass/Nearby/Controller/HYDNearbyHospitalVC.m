//
//  HYDNearbyHospitalVC.m
//  HaoYiDao
//
//  Created by Sprixin on 16/6/2.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDNearbyHospitalVC.h"
#import "HYDNearbyHospitalVIew.h"
#import "HYDNearbyHospitalModel.h"
#import "HYDNearbyCommon.h"
#import "CustomAnnotationView.h"
#import "HYDNearbyDepartmentsModel.h"
#import "HYDDrugInfoPopVC.h"
#import "HYDPointAnnotation.h"

@interface HYDNearbyHospitalVC ()<MAMapViewDelegate>

@property (nonatomic,strong) HYDNearbyHospitalVIew *hospitalView;
@property (nonatomic,strong) HYDNearbyHospitalModel *model;
@property (nonatomic,strong) MAPointAnnotation *pointAnn;
@property (nonatomic,strong) NSMutableArray *Departments;

@end

@implementation HYDNearbyHospitalVC

- (void)loadView {
    [super loadView];
    
    self.hospitalView = [[HYDNearbyHospitalVIew alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _hospitalView;
    _hospitalView.mapView.showsUserLocation = YES;
    _hospitalView.mapView.centerCoordinate = _hospitalView.mapView.userLocation.coordinate;
    _hospitalView.mapView.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self p_requestData];
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_hospitalView.mapView setZoomLevel:13.f animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_hospitalView.mapView clearDisk];
    
}


- (void) p_requestData {
    
    self.model = [[HYDNearbyHospitalModel alloc]init];
    NSString *httpArg = [NSString stringWithFormat:@"id=%@",_id];
    NSString *urlString = [[NSString alloc]initWithFormat: @"%@?%@", HYDNEARBYTIANGOUHOSPITALSHOW, httpArg];
    
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
                    [self p_requsetDepartments];
                });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
    });
}


- (void) p_setupFetures {
    
    NSString *imgString = [NSString stringWithFormat:@"http://tnfs.tngou.net/img%@",_model.img];
    [_hospitalView.iconImageView sd_setImageWithURL:[NSURL URLWithString:imgString]
                                   placeholderImage:[UIImage imageNamed:@"logo_button"]];
    self.title = @"医院详情";
    _hospitalView.nameLabel.text = _model.name;
    _hospitalView.levelLabel.text = _model.level;
    _hospitalView.typeLabel.text = _model.mtype;
    _hospitalView.addressLabel.text = _model.address;
    [_hospitalView.messageView loadHTMLString:_model.message baseURL:nil];
    if (!_model.tel)
        _hospitalView.telButton.hidden = YES;
    else
        [_hospitalView.telButton setTitle:_model.tel forState:(UIControlStateNormal)];
    [_hospitalView.telButton addTarget:self
                                action:@selector(telButtonAct:)
                      forControlEvents:(UIControlEventTouchUpInside)];

}

- (void) p_setupAnnotation {

    self.pointAnn = [[MAPointAnnotation alloc]init];
    _pointAnn.coordinate = CLLocationCoordinate2DMake([_model.y floatValue], [_model.x floatValue]);
    [_hospitalView.mapView addAnnotation:_pointAnn];
    
}

- (void) p_setupView {
    
    CGFloat x = 10;
    CGFloat y = CGRectGetMaxY(_hospitalView.label.frame) + 10;
    CGFloat w = _hospitalView.bounds.size.width / 3 - 20;
    CGFloat h = _hospitalView.levelLabel.bounds.size.height;
    
    for (int i = 0; i < _Departments.count; i ++) {
        
        HYDNearbyDepartmentsModel *model = (HYDNearbyDepartmentsModel *)_Departments[i];
        
        int m = i / 3; // 整除
        int n = i % 3; // 取余
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        button.frame = CGRectMake(x + (20 + w) * n, y + (h + 10) * m, w, h);
        button.backgroundColor = HYD_themeColor;
        [button setTintColor:[UIColor whiteColor]];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.tag = 10000 + i;
        [button setTitle:model.name forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(DepartmentsAct:) forControlEvents:(UIControlEventTouchUpInside)];
        [_hospitalView.scrollView addSubview:button];
    }
    
    _hospitalView.scrollView.contentSize = CGSizeMake(0,
                                                      _hospitalView.bounds.size.height +
                                                      _hospitalView.bounds.size.width + 100 +
                                                      (_hospitalView.bounds.size.width * .1 + 20) *
                                                      (_Departments.count / 3 + 1));

    
    NSLog(@"count = %ld",_Departments.count);
}

- (void) DepartmentsAct:(UIButton *)sedner {
    
    HYDNearbyDepartmentsModel *model = (HYDNearbyDepartmentsModel *)_Departments[sedner.tag - 10000];
    HYDDrugInfoPopVC *popVC = [[HYDDrugInfoPopVC alloc]init];
    popVC.introduce = model.message;
    popVC.themeTitle = @"科室说明";
    [self presentViewController:popVC animated:YES completion:^{ }];
    
}

- (void) p_requsetDepartments {
    
    self.Departments = [NSMutableArray new];
    NSString *httpArg = [NSString stringWithFormat:@"id=%@",_model.id];
    NSString *urlString = [[NSString alloc]initWithFormat: @"%@?%@", HYDNEARBYTIANGOUHOSPITALFEATURE, httpArg];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:TNGOU_APIKEY forHTTPHeaderField:@"apikey"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"text/xml"] forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictionary = [NSDictionary dictionary];
        dictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers |
                      NSJSONReadingMutableLeaves error:nil];
        
        NSArray *array = [NSArray arrayWithArray:[dictionary valueForKey:@"tngou"]];
        for (NSDictionary *dic in array) {
            HYDNearbyDepartmentsModel *model = [[HYDNearbyDepartmentsModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_Departments addObject:model];
        }
        [self p_setupView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];

    
}


- (void) telButtonAct:(UIButton *)sender {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",sender.titleLabel.text]];
    [[UIApplication sharedApplication] openURL:url];
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
        [_hospitalView.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
        
    }
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [_hospitalView.mapView clearDisk];

}

@end
