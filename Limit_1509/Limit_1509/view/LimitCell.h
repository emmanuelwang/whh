//
//  LimitCell.h
//  Limit_1509
//
//  Created by block on 15/7/28.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "LimitModel.h"
@interface LimitCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet StarView *myStarView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;

- (void)configModel:(LimitModel *)model index:(NSInteger)index cutLength:(NSInteger)cutLength;
@end
