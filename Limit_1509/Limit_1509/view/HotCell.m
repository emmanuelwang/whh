//
//  HotCell.m
//  Limit_1509
//
//  Created by block on 15/7/29.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "HotCell.h"
#import "UIImageView+WebCache.h"
@implementation HotCell
- (void)config:(LimitModel *)model index:(NSInteger)index
{
    if (index %2 == 0) {
        self.bgImageView.image = [UIImage imageNamed:@"cate_list_bg1"];
    }else{
        self.bgImageView.image = [UIImage imageNamed:@"cate_list_bg2"];
    }
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    self.leftImageView.layer.masksToBounds = YES;
    self.leftImageView.layer.cornerRadius = 10;
    self.titleLabel.text = model.name;
    self.rateLabel.text = [NSString stringWithFormat:@"评分:%.1f",model.starCurrent.floatValue];
    self.curPriceLabel.text = [NSString stringWithFormat:@"￥:%@",model.lastPrice];
    [self.myStarView setRating:model.starCurrent.floatValue];
    self.typeLabel.text = model.categoryName;
    self.sharesLabel.text = [NSString stringWithFormat:@"分享:%@",model.shares];
    self.favoritesLabel.text = [NSString stringWithFormat:@"收藏:%@",model.favorites];
    self.downloadsLabel.text = [NSString stringWithFormat:@"下载:%@",model.downloads];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
