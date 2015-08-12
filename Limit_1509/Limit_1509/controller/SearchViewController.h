//
//  SearchViewController.h
//  Limit_1509
//
//  Created by block on 15/7/29.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchViewController : BaseViewController

typedef NS_ENUM(NSInteger, SearchType)
{
    SearchTypeLimit = 10,//限免
    SearchTypeReduce, //降价
    SearchTypeFree,  //免费
    SearchTypeHot,  //热榜
};

@property (nonatomic , strong) NSString *keyword;

@property (nonatomic,assign) SearchType type;
@end
