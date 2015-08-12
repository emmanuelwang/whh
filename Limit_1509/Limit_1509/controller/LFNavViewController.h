//
//  LFNavViewController.h
//  Limit_1509
//
//  Created by block on 15/7/30.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CONST.h"
#import "MyDownloader.h"


@interface LFNavViewController : UIViewController

- (UIButton *)addNavBtn:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action isLeft:(BOOL)isLeft;

- (UILabel *)addNavTitle:(CGRect)frame title:(NSString *)title;


@end
