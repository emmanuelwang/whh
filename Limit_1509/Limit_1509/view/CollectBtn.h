//
//  CollectBtn.h
//  Limit_1509
//
//  Created by block on 15/8/3.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectItem.h"

@protocol CollectBtnDelegate <NSObject>

//- (void)didDeleteBtnWithAppId:(NSString *)applicationId;

- (void)didDeleteBtnWithIndex:(NSInteger)index;
@end

@interface CollectBtn : UIControl
{
    UIImageView *_imageView;
    
    UILabel *_textLabel;
    
    UIButton *_deleteBtn;
}

@property (nonatomic , strong) CollectItem *cItem;

//设置编辑状态
@property (nonatomic , assign) BOOL edit;

@property (nonatomic, weak)id<CollectBtnDelegate>delegate;
@end
