//
//  StarView.m
//  Limit_1509
//
//  Created by block on 15/7/28.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "StarView.h"
#import "MyUtil.h"
@implementation StarView
//代码的方式初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createImageView];
    }
    return self;
}

//xib的方式初始化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self createImageView];
    }
    return self;
}
//初始化图片
- (void)createImageView
{
    UIImageView *bgImageView = [MyUtil createImageViewFrame:CGRectMake(0, 0, 65, 23) imageName:@"StarsBackground"];
     [self addSubview:bgImageView];
    UIImageView *fgImageview = [MyUtil createImageViewFrame:CGRectMake(0, 0, 65, 23) imageName:@"StarsForeground"];
    
    fgImageview.contentMode = UIViewContentModeLeft;
    fgImageview.clipsToBounds = YES;
    fgImageview.tag = 200;
    [self addSubview:fgImageview];
   
}

- (void)setRating:(float)rating
{
    //修改前面视图的frame
    UIImageView *imageView = (UIImageView *)[self viewWithTag:200];
    imageView.frame = CGRectMake(0, 0, 65*rating/5.0f, 23);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
