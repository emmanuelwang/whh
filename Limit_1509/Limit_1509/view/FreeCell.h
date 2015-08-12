//
//  FreeCell.h
//  Limit_1509
//
//  Created by block on 15/7/29.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "LimitModel.h"
@interface FreeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageVIew;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet StarView *myStarView;
@property (weak, nonatomic) IBOutlet UILabel *sharesLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritesLabel;
@property (weak, nonatomic) IBOutlet UILabel *downloadsLabel;

- (void)configModel:(LimitModel *)model index:(NSInteger)index;
@end
