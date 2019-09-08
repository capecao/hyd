//
//  MedicationModel+CoreDataProperties.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/28.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "MedicationModel+CoreDataProperties.h"

@implementation MedicationModel (CoreDataProperties)

+ (NSFetchRequest<MedicationModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MedicationModel"];
}

@dynamic drugName;
@dynamic remarks;
@dynamic repeat;
@dynamic startTime;
@dynamic takeTimes;
@dynamic userName;
@dynamic warring;

@end
