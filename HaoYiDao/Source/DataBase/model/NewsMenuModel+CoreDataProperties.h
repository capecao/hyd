//
//  NewsMenuModel+CoreDataProperties.h
//  HaoYiDao
//
//  Created by capecao on 2017/4/28.
//  Copyright © 2017年 cape. All rights reserved.
//

#import "NewsMenuModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface NewsMenuModel (CoreDataProperties)

+ (NSFetchRequest<NewsMenuModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *channelId;
@property (nullable, nonatomic, copy) NSString *channelName;
@property (nullable, nonatomic, copy) NSString *channelType;

@end

NS_ASSUME_NONNULL_END
