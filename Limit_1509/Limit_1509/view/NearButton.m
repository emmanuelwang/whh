//
//  NearButton.m
//  Limit_1509
//
//  Created by block on 15/7/30.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "NearButton.h"
#import "MyUtil.h"
#import "UIImageView+WebCache.h"
@implementation NearButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _appImageView = [MyUtil createImageViewFrame:CGRectMake(0, 0, 80, 60) imageName:nil];
        _appImageView.layer.masksToBounds = YES;
        _appImageView.layer.cornerRadius = 10;
        [self addSubview:_appImageView];
        
        _nameLabel = [MyUtil createLabelFrame:CGRectMake(0, 60, 80, 20) title:nil font:[UIFont systemFontOfSize:12]];
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void)setAppModel:(LimitModel *)appModel
{
    _appModel = appModel;
    
    //显示图片和文字
    [_appImageView sd_setImageWithURL:[NSURL URLWithString:appModel.iconUrl]];
    _nameLabel.text = appModel.name;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
