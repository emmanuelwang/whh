//
//  MyUtil.h
//  Limit_1509
//
//  Created by block on 15/7/27.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyUtil : NSObject
/*
 @param frame:控件的大小
 @param title:标签的文字
 @param font:字体大小
 @param alignment:对齐方式
 @param numberOfLines:文字显示的行数
 @param textColor:文字颜色
*/
+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textAlignment:(NSTextAlignment)alignment numbersOfLines:(NSInteger)numberOfLines textColor:(UIColor *)textColor;

+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font;

/*
 @param frame:按钮大小
 @param title:按钮文字
 @param bgImageName:背景图片
 */
+ (UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title bgImageName:(NSString *)bgImageName targe:(id)target action:(SEL)action;

//创建图片视图
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;
@end
