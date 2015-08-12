//
//  CategoryViewController.h
//  Limit_1509
//
//  Created by block on 15/7/31.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "LFNavViewController.h"
@protocol CategoryViewControllerDelegate<NSObject>
- (void)didSelectCateId:(NSString *)categoryId titleString:(NSString *)cateName;
@end
@interface CategoryViewController : LFNavViewController

@property (nonatomic, strong)NSString *titleString;

@property (nonatomic , strong) NSString *urlString;

@property (nonatomic , weak) id<CategoryViewControllerDelegate> delegate;
@end
