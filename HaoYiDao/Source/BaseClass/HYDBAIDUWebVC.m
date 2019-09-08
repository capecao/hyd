//
//  HYDBAIDUWebVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/20.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDBAIDUWebVC.h"
#import <WebKit/WebKit.h>

@interface HYDBAIDUWebVC ()

@property (nonatomic,strong) WKWebView *webView;

@end

@implementation HYDBAIDUWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    
    [_webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}



@end
