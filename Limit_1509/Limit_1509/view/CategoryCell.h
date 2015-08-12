//
//  CategoryCell.h
//  Limit_1509
//
//  Created by block on 15/7/31.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryItem.h"
@interface CategoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cateImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

- (void)configItem:(CategoryItem *)cateItem;
@end
