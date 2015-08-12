//
//  MyDownloader.h
//  Limit_1509
//
//  Created by block on 15/7/27.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyDownloader;
@protocol MyDownLoaderDelegate <NSObject>
//下载失败
- (void)downloader:(MyDownloader *)downloader failWithError:(NSError *)error;

//下载成功
- (void)downloaderFinish:(MyDownloader *)downloader;
@end


@interface MyDownloader : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

- (void)downloadWithUrlString:(NSString *)urlString;

@property (nonatomic,weak)id<MyDownLoaderDelegate>delegate;
//获取下载的数据
@property (nonatomic,readonly)NSData *receiveData;

//类型
@property (nonatomic , assign) NSInteger type;
@end
