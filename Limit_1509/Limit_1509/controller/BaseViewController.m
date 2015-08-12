//
//  BaseViewController.m
//  Limit_1509
//
//  Created by block on 15/7/27.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "BaseViewController.h"
#import "MyUtil.h"

@interface BaseViewController ()
{
   
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    _isLoading = NO;
    _currentPage = 1;
    [self createTableView];
}
- (void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 375, 667-64)];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    //去掉分割线
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tbView];
    
    //下拉刷新
    _headerView = [MJRefreshHeaderView header];
    _headerView.scrollView = _tbView;
    _headerView.delegate = self;
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.scrollView = _tbView;
    _footerView.delegate = self;
    
    [_headerView beginRefreshing];
}

- (UIButton *)addNavBtn:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action isLeft:(BOOL)isLeft {
    UIButton *btn = [MyUtil createBtnFrame:frame title:title bgImageName:@"buttonbar_action" targe:target action:action];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
    return btn;
}

- (UILabel *)addNavTitle:(CGRect)frame title:(NSString *)title {
    UIColor *color = [UIColor colorWithRed:80.0f/255.0f green:180.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    UILabel *label = [MyUtil createLabelFrame:frame title:title font:[UIFont boldSystemFontOfSize:28] textAlignment:NSTextAlignmentCenter numbersOfLines:1 textColor:color];
    self.navigationItem.titleView = label;
    return label;
}

- (void)dealloc
{
    _headerView.scrollView = nil;
    _footerView.scrollView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"子类必须实现方法%s",__FUNCTION__);
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"子类必须实现方法%s",__FUNCTION__);
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
