//
//  CollectViewController.m
//  Limit_1509
//
//  Created by block on 15/8/3.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "CollectViewController.h"
#import "DBManager.h"
#import "CollectBtn.h"
#import "DetailViewController.h"
@interface CollectViewController ()<CollectBtnDelegate,UIScrollViewDelegate>
{
    //显示应用信息
    UIScrollView *_scrollView;
    
    UIButton *_editBtn;
    
    UIPageControl *_pageCtrl;
}
@property (nonatomic , strong) NSMutableArray *dataArray;
@end

@implementation CollectViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];;
    // Do any additional setup after loading the view.
    [self createMyNav];
    [self createScrollView];
    [self searchApps];
}

- (void)createScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 375, 667-64-49)];
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
    _pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(60, 550, 255, 40)];
    [self.view addSubview:_pageCtrl];
}
- (void)searchApps
{
    //ispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)获取系统的并列线程队列
    //dispatch_async异步执行
    __weak CollectViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *array = [[DBManager sharedInstance] searchAllFavoriteApps];
        weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createBtns];
        });
    });
}
- (void)createMyNav
{
    UIButton *backBtn = [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"返回" target:self action:@selector(backAction:) isLeft:YES];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"我的收藏"];
    _editBtn = [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"编辑" target:self action:@selector(editAction:) isLeft:NO];
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editAction:(id)sender
{
    if ([[_editBtn currentTitle] isEqualToString:@"编辑"]) {
        for (UIView *sub in _scrollView.subviews) {
            if ([sub isKindOfClass:[CollectBtn class]]) {

            CollectBtn *btn = (CollectBtn *)sub;
            btn.edit = YES;
        
            }
        }
        [_editBtn setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        for (UIView *sub in _scrollView.subviews) {
            if ([sub isKindOfClass:[CollectBtn class]]) {
                CollectBtn *btn = (CollectBtn *)sub;
                btn.edit = NO;
            }
        }
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
}

- (void)createBtns
{
    
    for (UIView *sub in _scrollView.subviews) {
        if ([sub isKindOfClass:[CollectBtn class]]) {
        
            [sub removeFromSuperview];
        }
    }
    
    CGFloat w = 80;
    CGFloat h = 100;
    CGFloat spaceX = 40;
    CGFloat spaceY = 60;
    
    for (int i=0; i<self.dataArray.count; i++) {
        CollectItem *cItem = self.dataArray[i];
        int page = i/9;
        int rowAndCol = i%9;
        
        int row = rowAndCol/3;
        int col = rowAndCol%3;
        
        CGRect frame = CGRectMake(40+(w+spaceX)*col+375*page, 40+(h+spaceY)*row, w, h);
        CollectBtn *btn = [[CollectBtn alloc]initWithFrame:frame];
        btn.cItem = cItem;
        btn.tag = 300+i;
        if ([[_editBtn titleForState:UIControlStateNormal]isEqualToString:@"编辑"]) {
            btn.edit = NO;
        }else{
            btn.edit = YES;
        }
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.delegate = self;
        [_scrollView addSubview:btn];
    }
    
    NSInteger cnt = self.dataArray.count/9;
    if (self.dataArray.count%9 >0) {
        cnt++;
    }
    
    _scrollView.contentSize = CGSizeMake(375*cnt, _scrollView.bounds.size.height);
    _scrollView.delegate = self;
    _pageCtrl.numberOfPages = cnt;
    
}


- (void)clickBtn:(UIButton *)btn
{
    NSInteger index = btn.tag - 300;
    
    CollectItem *cItem = self.dataArray[index];
    
    DetailViewController *dVC = [[DetailViewController alloc]init];
    dVC.applicationId = cItem.applicationId;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - CollectBtnDelegate
//- (void)didDeleteBtnWithAppId:(NSString *)applicationId
//{
//    [[DBManager sharedInstance] deleteAppWithAppId:applicationId];
//    [self searchApps];
//}

- (void)didDeleteBtnWithIndex:(NSInteger)index
{
    CollectItem *cItem = self.dataArray[index];
    [[DBManager sharedInstance]deleteAppWithAppId:cItem.applicationId];
    
    [self.dataArray removeObjectAtIndex:index];
    [self createBtns];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    _pageCtrl.currentPage = index;
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
