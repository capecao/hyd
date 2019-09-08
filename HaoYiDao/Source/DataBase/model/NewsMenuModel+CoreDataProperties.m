//
//  NewsMenuModel+CoreDataProperties.m
//  HaoYiDao
//
//  Created by capecao on 2017/4/28.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "NewsMenuModel+CoreDataProperties.h"

@implementation NewsMenuModel (CoreDataProperties)

+ (NSFetchRequest<NewsMenuModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NewsMenuModel"];
}

@dynamic channelId;
@dynamic channelName;
@dynamic channelType;

@end
