//
//  CollectBtn.m
//  Limit_1509
//
//  Created by block on 15/8/3.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "CollectBtn.h"
#import "MyUtil.h"
@implementation CollectBtn


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imageView = [MyUtil createImageViewFrame:CGRectMake(20, 20, 60, 60) imageName:nil];
        _imageView.layer.cornerRadius = 10;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        
        _textLabel = [MyUtil createLabelFrame:CGRectMake(20, 80, 60, 20) title:nil font:[UIFont systemFontOfSize:10]];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
        
        _deleteBtn = [MyUtil createBtnFrame:CGRectMake(0, 0, 40, 40) title:nil bgImageName:@"close" targe:self action:@selector(deleteAction:)];
        _deleteBtn.hidden = YES;
        [self addSubview:_deleteBtn];
    }
    return self;
}

- (void)deleteAction:(id)sender
{
    if (self.delegate) {
    //[self.delegate didDeleteBtnWithAppId:self.cItem.applicationId];
        [self.delegate didDeleteBtnWithIndex:self.tag - 300];
    }
}

- (void)setCItem:(CollectItem *)cItem
{
    _cItem = cItem;
    
    _imageView.image = _cItem.image;
    _textLabel.text = _cItem.name;
    
}

- (void)setEdit:(BOOL)edit
{
    _edit = edit;
    if (edit) {
        _deleteBtn.hidden = NO;
    }else{
        _deleteBtn.hidden = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
