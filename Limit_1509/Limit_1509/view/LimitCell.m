//
//  LimitCell.m
//  Limit_1509
//
//  Created by block on 15/7/28.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "LimitCell.h"
#import "UIImageView+WebCache.h"
@implementation LimitCell

- (void)configModel:(LimitModel *)model index:(NSInteger)index cutLength:(NSInteger)cutLength
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
    
    //时间
    NSString *dateStr = [model.expireDatetime substringToIndex:model.expireDatetime.length-cutLength];
    //转化成日期
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [df dateFromString:dateStr];
    
    ///计算时间差
    unsigned int unit = NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    /*
     第一个参数:时间差里面包含的内容(年,月,日,时,分,秒)
     第四个参数:比较的一些附加参数
     */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dc = [calendar components:unit fromDate:[NSDate date] toDate:date options:0];
    self.timelabel.text = [NSString stringWithFormat:@"剩余:%02ld:%02ld:%02ld",[dc hour],[dc minute],[dc second]];
    
    //价格
    self.priceLabel.text = [NSString stringWithFormat:@"￥:%@",model.lastPrice];
    //横线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 60, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    [self.priceLabel addSubview:lineView];
    //星级
    [self.myStarView setRating:model.starOverall.floatValue];
    //类型
    self.typeLabel.text = model.categoryName;
    //收藏
    self.favoriteLabel.text =[NSString stringWithFormat:@"收藏:%@",model.favorites];
    self.shareLabel.text = [NSString stringWithFormat:@"分享:%@",model.shares];
    self.downloadLabel.text = [NSString stringWithFormat:@"下载:%@",model.downloads];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
