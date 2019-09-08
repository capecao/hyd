//
//  MedicationModel+CoreDataProperties.h
//  HaoYiDao
//
//  Created by capecao on 2017/4/28.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "MedicationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicationModel (CoreDataProperties)

+ (NSFetchRequest<MedicationModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *drugName;
@property (nullable, nonatomic, copy) NSString *remarks;
@property (nullable, nonatomic, copy) NSString *repeat;
@property (nullable, nonatomic, copy) NSString *startTime;
@property (nullable, nonatomic, copy) NSString *takeTimes;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, copy) NSString *warring;

@end

NS_ASSUME_NONNULL_END
