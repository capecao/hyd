//
//  HYDHomeMedicationsVC.m
//  HaoYiDao
//
//  Created by capecao on 16/9/7.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeMedicationsVC.h"
#import "HYDHomeMedicalAddVC.h"
#import "HYDHomeMedicationsCell.h"
#import "HYDHomePageCommon.h"
#import "HYDMedicationWarring.h"

@interface HYDHomeMedicationsVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HYDHomeMedicationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用药管理";
    [self p_setupNavigationItem];
    [self p_setupTableView];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self p_setupData];
    [_tableView reloadData];
}

- (void) p_setupNavigationItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItemAction:)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
}


- (void) rightBarButtonItemAction:(UIBarButtonItem *)sender {
    
    [self.navigationController pushViewController:[[HYDHomeMedicalAddVC alloc]init] animated:YES];
}

- (void) p_setupTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0, 0, self.view.bounds.size.width,
                                 self.view.bounds.size.height - 64)
                                                 style:(UITableViewStylePlain)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[HYDHomeMedicationsCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void) p_setupData {
    
    self.dataArray = [NSMutableArray arrayWithArray:[MedicationModel MR_findAll]];
    [_tableView reloadData];
}

#pragma mark UITableViewDataSource,UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHomeMedicationsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    MedicationModel *model = _dataArray[indexPath.row];
    cell.durgLab.text = [NSString stringWithFormat:@"提醒%@服用%@",
                         model.userName,model.drugName];
    cell.infoLab.text = [NSString stringWithFormat:@"%@ %@",model.repeat,model.takeTimes];
    
    if ([model.warring isEqualToString:@"1"])
        [cell.isOnSwitch setOn:YES animated:YES];
    else
        [cell.isOnSwitch setOn:NO animated:YES];
    
    cell.isOnSwitch.tag = 1000000 + indexPath.row;
    [cell.isOnSwitch addTarget:self action:@selector(isOnSwitchAct:) forControlEvents:(UIControlEventValueChanged)];
    
    return cell;
}

- (void) isOnSwitchAct:(UISwitch *)sender {
    
    NSString *warring = @"0";
    if (sender.isOn) {
        warring = @"1";
    }else {
        warring = @"0";
    }
    MedicationModel *model = _dataArray[sender.tag - 1000000];
    model.warring = warring;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [[HYDMedicationWarring shareInstance] IsRequestWarrings];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60 * HEIGHTSCALE;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [_dataArray removeObjectAtIndex:indexPath.row];
        MedicationModel *model = _dataArray[indexPath.row];
        [model MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDHomeMedicalAddVC *vc = [[HYDHomeMedicalAddVC alloc]init];
    MedicationModel *model = _dataArray[indexPath.row];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
