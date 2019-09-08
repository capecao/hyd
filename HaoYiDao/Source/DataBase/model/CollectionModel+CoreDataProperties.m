//
//  CollectionModel+CoreDataProperties.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/28.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "CollectionModel+CoreDataProperties.h"

@implementation CollectionModel (CoreDataProperties)

+ (NSFetchRequest<CollectionModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CollectionModel"];
}

@dynamic htmlString;
@dynamic loadType;
@dynamic title;
@dynamic urlString;

@end
