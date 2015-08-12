//
//  BaseViewController.h
//  Limit_1509
//
//  Created by block on 15/7/27.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "LFNavViewController.h"
@interface BaseViewController : LFNavViewController <UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    NSMutableArray *_dataArray;
    
    UITableView *_tbView;
    
    MJRefreshHeaderView *_headerView;
    MJRefreshFooterView *_footerView;
    
    BOOL _isLoading;
    NSInteger _currentPage;
}
/*
 @param isLeft:是否是左边的按钮
 */
- (UIButton *)addNavBtn:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action isLeft:(BOOL)isLeft;

- (UILabel *)addNavTitle:(CGRect)frame title:(NSString *)title;
@end
