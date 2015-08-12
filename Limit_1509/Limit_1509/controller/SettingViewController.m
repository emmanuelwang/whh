//
//  SettingViewController.m
//  Limit_1509
//
//  Created by block on 15/8/3.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "SettingViewController.h"
#import "MyUtil.h"
#import "CollectViewController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMyNav];
    [self createBtns];
}


- (void)createMyNav
{
    UIButton *btn = [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"返回" target:self action:@selector(backAction:) isLeft:YES];
    [btn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"设置"];
}

- (void)backAction: (id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createBtns
{
    NSArray *imageArray = @[@"account_setting",@"account_favorite",@"account_user",@"account_collect",@"account_download",@"account_comment",@"account_help",@"account_candou"];
    NSArray *nameArray = @[@"我的设置",@"我的关注",@"我的账号",@"我的收藏",@"我的下载",@"我的评论",@"我的帮助",@"蚕豆应用"];
    
    CGFloat w = 60;
    CGFloat h = 80;
    CGFloat spaceX = 45;
    CGFloat spaceY = 80;
    
    for (NSInteger i=0; i<imageArray.count; i++) {
        NSInteger row = i/3;
        NSInteger col = i%3;
        CGRect frame = CGRectMake(60+(w+spaceX)*col, 64+40+(h+spaceY)*row, w, h);
        UIButton *btn = [MyUtil createBtnFrame:frame title:nil bgImageName:nil targe:self action:@selector(clickBtn:)];
        btn.tag = 300+i;
        
        UIImageView *imgView = [MyUtil createImageViewFrame:CGRectMake(0, 0, 60, 60) imageName:imageArray[i]];
        [btn addSubview:imgView];
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(0, 60, 60, 20) title:nameArray[i] font:[UIFont systemFontOfSize:12]];
        label.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:label];
                                
        [self.view addSubview:btn];
    }
}

- (void)clickBtn: (UIButton *)btn
{
    NSInteger index = btn.tag - 300;
    NSLog(@"点击了第%ld个按钮",index+1);
    if (index == 3) {
        CollectViewController *collectVC = [[CollectViewController alloc]init];
        [self.navigationController pushViewController:collectVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
