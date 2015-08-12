//
//  DBManager.m
//  Limit_1509
//
//  Created by block on 15/8/3.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
@implementation DBManager
{
    FMDatabase *_myDataBase;
}
+ (DBManager *)sharedInstance
{
    static DBManager *manager =nil;
    static dispatch_once_t onceTaken;
    dispatch_once(&onceTaken,^{
        manager = [[DBManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createDatabase];
    }
    return self;
}

- (void)createDatabase
{
   NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/app.sqlite"];
    NSLog(@"%@",path);
    
    _myDataBase = [[FMDatabase alloc] initWithPath:path];
    
    BOOL ret = [_myDataBase open];
    if (ret) {
        //数据库打开正常
        
        //创建表格(对应于代码中的一个类
        //表明:collect
        //字段:id(数据库序号), applicationId(应用的id), name(应用名称), image(图片)
        NSString *createSql = @"create table if not exists collect(id integer primary key autoincrement, applicationId varchar(20), name varchar(255), image blob)";
        BOOL flag = [_myDataBase executeUpdate:createSql];
        if (flag) {
            
        }else{
            NSLog(@"创建表格失败");
        }
        
    }else{
        NSLog(@"数据库打开失败");
    }
}

- (void)addCollect:(CollectItem *)cItem
{
    NSString *insertSql = @" insert into collect(applicationId, name, image) values(?,?,?)";
    UIImage *image = cItem.image;
    NSData *data = UIImagePNGRepresentation(image);
    BOOL success = [_myDataBase executeUpdate:insertSql,cItem.applicationId,cItem.name,data];
    if (!success) {
        NSLog(@"增加数据失败:%@",_myDataBase.lastErrorMessage);
    }
}

- (BOOL)isAppFavorite:(NSString *)appId
{
    //NSString *selectSql = @"select * from collect where applicationId = ?";
    //count(*)是数据库的函数,计算满足条件的数据的个数
    //as cnt给数值取一个别名叫做cnt
    NSString *selectSql = @"select count(*) as cnt from collect where applicationId = ?";
    FMResultSet *rs = [_myDataBase executeQuery:selectSql,appId];
    //获取记录个数
    NSInteger count = 0;
    if ([rs next]) {
        count = [rs longForColumn:@"cnt"];
    }
    if (count>0) {
        return YES;
    }else{
        return NO;
    }
}

- (NSArray *)searchAllFavoriteApps
{
    NSString *selectSql = @"select * from collect";
    NSMutableArray *resultArray = [NSMutableArray array];
    FMResultSet *rs = [_myDataBase executeQuery:selectSql];
    while ([rs next]) {
        //创建一个对象
        CollectItem *cItem = [[CollectItem alloc]init];
        cItem.collectId = [rs intForColumn:@"id"];
        cItem.applicationId = [rs stringForColumn:@"applicationId"];
        cItem.name = [rs stringForColumn:@"name"];
        NSData *data = [rs dataForColumn:@"image"];
        cItem.image = [UIImage imageWithData:data];
        [resultArray addObject:cItem];
    }
    return resultArray;
}

- (void)deleteAppWithAppId:(NSString *)appId
{
    NSString *deleteSql = @"delete from collect where applicationId = ?";
   BOOL ret = [_myDataBase executeUpdate:deleteSql,appId];
    if (!ret) {
        NSLog(@"%@",_myDataBase.lastErrorMessage);
    }
    
}
@end
