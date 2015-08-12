//
//  MyDownloader.m
//  Limit_1509
//
//  Created by block on 15/7/27.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "MyDownloader.h"

@implementation MyDownloader
{
    //下载对象
    NSURLConnection *_cnn;
    //存储下载的数据
    NSMutableData *_receiveData;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化下载数据的对象
        _receiveData = [NSMutableData data];
    }
    return self;
}

- (void)downloadWithUrlString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //创建NSURLConnection对象
    _cnn = [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnection代理
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.delegate) {
        [self.delegate downloader:self failWithError:error];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_receiveData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];
}
//下载完成,程序会自动切换到主线程
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.delegate) {
        [self.delegate downloaderFinish:self];
    }
}
@end
