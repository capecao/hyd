//
//  CollectionModel+CoreDataProperties.h
//  HaoYiDao
//
//  Created by capecao on 2017/4/28.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "CollectionModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CollectionModel (CoreDataProperties)

+ (NSFetchRequest<CollectionModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *htmlString;
@property (nonatomic) int64_t loadType;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *urlString;

@end

NS_ASSUME_NONNULL_END
