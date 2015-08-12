//
//  DBManager.h
//  Limit_1509
//
//  Created by block on 15/8/3.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectItem.h"
@interface DBManager : NSObject

+ (DBManager *)sharedInstance;


//增加
- (void)addCollect:(CollectItem *)cItem;

- (BOOL)isAppFavorite:(NSString *)appId;

//查询所有收藏数据
- (NSArray *)searchAllFavoriteApps;

- (void)deleteAppWithAppId:(NSString *)appId;
@end
