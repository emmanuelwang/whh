//
//  MainTabBarController.m
//  Limit_1509
//
//  Created by block on 15/7/27.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createControllers];
}

//创建视图控制器
- (void)createControllers {
    //视图控制器类名
    NSArray *ctrlArray = @[@"LimitFreeViewController",@"ReduceViewController",@"FreeViewController",@"SubjectViewController",@"HotViewController"];
    //标题文字
    NSArray *nameArray = @[@"限免",@"降价",@"免费",@"专题",@"热榜"];
    NSArray *imageArray = @[@"tabbar_limitfree",@"tabbar_reduceprice",@"tabbar_appfree",@"tabbar_subject",@"tabbar_rank"];
    NSArray *selectedArray = @[@"tabbar_limitfree_press",@"tabbar_reduceprice_press",@"tabbar_appfree_press",@"tabbar_subject_press",@"tabbar_rank_press"];
    NSMutableArray *navArray = [NSMutableArray array];
    for (NSInteger i=0; i<ctrlArray.count; i++) {
        NSString *className = ctrlArray[i];
        
        Class cls = NSClassFromString(className);
        UIViewController *vc = [[cls alloc]init];
        //图片显示
        NSString *imageName = imageArray[i];
        NSString *selectedName = selectedArray[i];
        //表示原始图片
        vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.title = nameArray[i];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [navArray addObject:nav];
    }
    self.viewControllers = navArray;
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
