//
//  SubjectCell.m
//  Limit_1509
//
//  Created by block on 15/7/31.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "SubjectCell.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"
@implementation SubjectCell
//代码的方式
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createAppButtons];
    }
    return  self;
}

//XIb的方式
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createAppButtons];
    }
    return self;
}

- (void)createAppButtons
{
    for (NSInteger i =0; i<4; i++) {
        CGRect frame = CGRectMake(150, 48*i+40, 200, 48);
        AppButton *btn = [[AppButton alloc]initWithFrame:frame];
        btn.tag = 300+i;
        [self addSubview:btn];
    }
}
- (void)setSItem:(SubjectItem *)sItem
{
    _sItem = sItem;
    //显示数据
    //标题
    self.titleLabel.text = sItem.title;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:sItem.img]];
    [self.descImageview sd_setImageWithURL:[NSURL URLWithString:sItem.desc_img]];
    self.descLabel.text = sItem.desc;
    self.descLabel.numberOfLines = 0;
    
    //相关应用的内容
    for (NSInteger i=0; i<4; i++) {
        AppButton *btn = (AppButton *)[self viewWithTag:i+300];
        
        if (i<sItem.appArray.count){
        //设置属性
        AppItem *aItem = sItem.appArray[i];
        btn.aItem = aItem;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.hidden = NO;
        }
        else{
            btn.hidden =YES;
        }
    }
}

- (void)clickBtn:(AppButton *)btn
{
    NSInteger index = btn.tag - 300;
    AppItem *aItem = self.sItem.appArray[index];
//    if (self.delegate) {
//        [self.delegate didSelectedAppItem:aItem];
//    }
    if (self.clickBlock) {
        self.clickBlock(aItem);
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation AppButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _appImageView = [MyUtil createImageViewFrame:CGRectMake(0, 0, 40, 40) imageName:nil];
        [self addSubview:_appImageView];
        
        //标题
        _titleLabel = [MyUtil createLabelFrame:CGRectMake(50, 0, 130, 10) title:nil font:[UIFont systemFontOfSize:8]];
        [self addSubview:_titleLabel];
        
        UIImageView *commentImageView = [MyUtil createImageViewFrame:CGRectMake(50, 10, 10, 10) imageName:@"topic_Comment"];
        [self addSubview:commentImageView];
        
        _commentLabel = [MyUtil createLabelFrame:CGRectMake(60, 10, 60, 10) title:nil font:[UIFont systemFontOfSize:8 ]];
        
        [self addSubview:_commentLabel];
        
        UIImageView *downloadImageView = [MyUtil createImageViewFrame:CGRectMake(120, 10, 10, 10) imageName:@"topic_Download"];
        [self addSubview:downloadImageView];
        
        _downloadLabel = [MyUtil createLabelFrame:CGRectMake(130, 10, 50, 10) title:nil font:[UIFont systemFontOfSize:8]];
        [self addSubview:_downloadLabel];
        
        _myStarView = [[StarView alloc]initWithFrame:CGRectMake(50, 20, 65, 23)];
        _myStarView.userInteractionEnabled = NO;
        [self addSubview:_myStarView];
    }
    return self;
}

- (void)setAItem:(AppItem *)aItem
{
    _aItem = aItem;
    //显示数据
    //图片
    [_appImageView sd_setImageWithURL:[NSURL URLWithString:aItem.iconUrl]];
    //标题
    _titleLabel.text = aItem.name;
    //评论
    _commentLabel.text = [NSString stringWithFormat:@"%@",aItem.ratingOverall];
    //下载
    _downloadLabel.text = aItem.downloads;
    //星级
    [_myStarView setRating:aItem.starOverall.floatValue];
}

@end