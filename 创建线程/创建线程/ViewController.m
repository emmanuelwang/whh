//
//  ViewController.m
//  创建线程
//
//  Created by block on 15/8/7.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(50, 100, 100, 40);
    [btn1 setTitle:@"按钮1" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(threadOne:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(50, 200, 100, 40);
    [btn2 setTitle:@"按钮2" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(threadTwo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

//第一种方式
- (void)threadOne:(id) sender
{
    NSNumber *n = @100;//@100 == [NSNumber numberWithInt:100];
    //参数1:线程执行体的方法
    //参数2:********所属的对象
    //参数3:********传递的参数
    [NSThread detachNewThreadSelector:@selector(createOne:) toTarget:self withObject:n];
}

- (void)createOne:(NSNumber *)n
{
    [NSThread currentThread].name = @"线程A";
    for (int i=0; i<n.intValue ; i++) {
        [NSThread sleepForTimeInterval:1];
        NSLog(@"执行%@:%d",[NSThread currentThread].name ,i);
    }
}

//第二种方式
- (void)threadTwo:(id)sender
{
    NSNumber *n = @50;
    //线程执行体方法所属的对象
    //线程执行体对应的方法
    //线程执行体方法的实参
    NSThread *t = [[NSThread alloc]initWithTarget:self selector:@selector(createTwo:) object:n];
    //设置线程的名字
    t.name = @"线程B";
    [t start];
}

- (void)createTwo:(NSNumber*)n
{
    for (int i =0; i<n.intValue; i++) {
        NSThread *t = [NSThread currentThread];
        NSLog(@"执行%@:%d",t.name,i);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
