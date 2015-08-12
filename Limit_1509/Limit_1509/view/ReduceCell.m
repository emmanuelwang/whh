//
//  ReduceCell.m
//  Limit_1509
//
//  Created by block on 15/7/29.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "ReduceCell.h"
#import "UIImageView+WebCache.h"

@implementation ReduceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configModel:(LimitModel *)model index:(NSInteger)index
{
    if (index % 2 == 0) {
        self.bgImageView.image = [UIImage imageNamed:@"cate_list_bg1"];
    }else{
        self.bgImageView.image = [UIImage imageNamed:@"cate_list_bg2"];
    }
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    self.leftImageView.layer.masksToBounds = YES;
    self.leftImageView.layer.cornerRadius = 10;
    self.titleLabel.text = model.name;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"现价:%@",model.currentPrice];
    //原价
    NSString *lastPrice = [NSString stringWithFormat:@"￥:%@",model.lastPrice];
    NSDictionary *dict = @{NSStrikethroughStyleAttributeName:@1};
    //NSStrikethroughStyleAttributeName表示在文字上面加横线
    //@1表示横线的高度为1 @1=[NSNumber numberWithInt:1]
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:lastPrice attributes:dict];
    self.lastPriceLabel.attributedText = string;
    
    self.typeLabel.text = model.categoryName;
    [self.myStarView setRating:model.starCurrent.floatValue];
    //收藏
    self.favoritesLabel.text =[NSString stringWithFormat:@"收藏:%@",model.favorites];
    self.sharesLabel.text = [NSString stringWithFormat:@"分享:%@",model.shares];
    self.downloadsLabel.text = [NSString stringWithFormat:@"下载:%@",model.downloads];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
