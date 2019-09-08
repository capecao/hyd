//
//  HYDUserCenterVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/18.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDUserCenterVC.h"
#import "HYDUserCenterCell.h"
#import "HYDUserCollectionVC.h"
#import "HYDUserProducerVC.h"
//#import "UMSocial.h"


@interface HYDUserCenterVC ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat cell_Row_Height;
    NSArray *dataArray;
}
@property (nonatomic,strong) UITableView *tableView;

@end


@implementation HYDUserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell_Row_Height = 50 * HEIGHTSCALE;
    dataArray = @[@"我的收藏",@"分享我们",@"清理缓存",@"联系我们"];
    
    [self p_setupTableView];
}

- (void) p_setupTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0, 0,
                                 self.view.bounds.size.width,
                                 cell_Row_Height * 5)
                                                 style:(UITableViewStylePlain)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.scrollEnabled = false;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HYDUserCenterCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    
    
}

#pragma mark 缓存
// 显示缓存大小
-(float) filePath {
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    return [ self folderSizeAtPath :cachPath];
    
}
//1:首先我们计算一下 单个文件的大小

- (long long) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    
    return 0 ;
}

//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

- (float) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
}

// 清理缓存

- (void) clearFile {
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
}

-(void)clearCachSuccess
{

    NSIndexPath *index=[NSIndexPath indexPathForRow:2 inSection:0];//刷新
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
    [ProgressHUD showSuccess:@"清理完毕！"];
}


#pragma mark UITableViewDataSource,UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDUserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.titLab.text = dataArray[indexPath.row];
    
    if (indexPath.row == 2)
    {
        cell.titLab.text = [NSString stringWithFormat:@"%@ (%.1f M)",dataArray[indexPath.row],[self filePath]];

    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cell_Row_Height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
    
        HYDUserCollectionVC *vc = [[HYDUserCollectionVC alloc]init];
        [self presentViewController:[[HYDNavigationController alloc]
                                     initWithRootViewController:vc]
                           animated:YES
                         completion:nil];
        
    }else if (indexPath.row == 1) {

//        NSString *title = [NSString stringWithFormat:@"%@.健康，医疗真需要",UMENG_SHARE_TEXT];
//
//        [UMSocialSnsService presentSnsIconSheetView:self appKey:UMENG_APIKEY shareText
//                                                   :title shareImage
//                                                   :[UIImage imageNamed:@"logo_button"]shareToSnsNames
//                                                   :[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,nil] delegate
//                                                   :nil];

        
    }else if (indexPath.row == 2) {

        UIAlertController *alertC =
        [UIAlertController alertControllerWithTitle:@"清理所有缓存？"
                                            message:nil
                                     preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定"
                                                         style:(UIAlertActionStyleCancel)
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [ProgressHUD show:@"清理中..."
                                                                 Interaction:NO];
                                                           
                                                           dispatch_after
                                                           (dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                               
                                                               [self clearFile];
                                                           });
                    }];
        UIAlertAction *other = [UIAlertAction actionWithTitle:@"取消"
                                                        style:(UIAlertActionStyleDefault)
                                                      handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertC addAction:cancel];
        [alertC addAction:other];

        [self presentViewController:alertC animated:YES completion:nil];
    }
    else if (indexPath.row == 3) {

        HYDUserProducerVC *vc = [[HYDUserProducerVC alloc]init];
        [self presentViewController:[[HYDNavigationController alloc]
                                     initWithRootViewController:vc]
                           animated:YES
                         completion:nil];
    }
}

@end
