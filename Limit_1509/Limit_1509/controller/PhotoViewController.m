//
//  PhotoViewController.m
//  Limit_1509
//
//  Created by block on 15/7/30.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "PhotoViewController.h"
#import "MyUtil.h"
#import "DetailItem.h"
#import "UIImageView+WebCache.h"
@interface PhotoViewController ()<UIScrollViewDelegate>

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMyNav];
    [self createPhoto];
}

#pragma mark - 状态栏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)createPhoto
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, 375, 300)];
    scrollView.delegate = self;
    for (NSInteger i=0; i<self.photoArray.count; i++) {
        //图片
        PhotoItem *pItem = self.photoArray[i];
        CGRect frame = CGRectMake(375*i, 0, 375, 300);
        UIImageView *tmpImageView = [MyUtil createImageViewFrame:frame imageName:nil];
        [tmpImageView sd_setImageWithURL:[NSURL URLWithString:pItem.originalUrl]];
        [scrollView addSubview:tmpImageView];
    }
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(375*self.photoArray.count, 300);
    [self.view addSubview:scrollView];
    scrollView.contentOffset = CGPointMake(375*self.index, 0);
}

- (void)createMyNav
{
    //背景图片
    UIImageView *bgImageView = [MyUtil createImageViewFrame:CGRectMake(0, 20, 375, 44) imageName:@"navigationbar"];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.tag = 500;
    [self.view addSubview:bgImageView];
    
    NSString *title = [NSString stringWithFormat:@"%ld of %ld",self.index+1,self.photoArray.count];
    UILabel *titleLabel = [MyUtil createLabelFrame:CGRectMake(100, 0, 175, 44) title:title font:[UIFont systemFontOfSize:20]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.tag = 600;
    [bgImageView addSubview:titleLabel];
    
    //按钮
    UIButton *btn = [MyUtil createBtnFrame:CGRectMake(300, 4, 60, 36) title:@"done" bgImageName:@"buttonbar_action" targe:self action:@selector(clickBtn:)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bgImageView addSubview:btn];
}

- (void)clickBtn:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScollView协议
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    UIImageView *bgImageView = (UIImageView *)[self.view viewWithTag:500];
    
    UILabel *titleLabel = (UILabel *)[bgImageView viewWithTag:600];
    
    titleLabel.text = [NSString stringWithFormat:@"%ld of %ld",index+1,self.photoArray.count];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
