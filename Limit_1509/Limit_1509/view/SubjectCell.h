//
//  SubjectCell.h
//  Limit_1509
//
//  Created by block on 15/7/31.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectItem.h"
#import "StarView.h"

@protocol SubjectCellDelegate <NSObject>

- (void)didSelectedAppItem:(AppItem *)aItem;

@end

@interface SubjectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *descImageview;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic , weak) id<SubjectCellDelegate> delegate;

@property (nonatomic , copy) void (^clickBlock)(AppItem *aItem);

@property (nonatomic , strong) SubjectItem *sItem;
@end

@interface AppButton : UIControl
{
    //图片
    UIImageView *_appImageView;
    UILabel *_titleLabel;
    UILabel *_commentLabel;
    UILabel *_downloadLabel;
    StarView *_myStarView;
    
}

@property (nonatomic, strong)AppItem *aItem;

@end
