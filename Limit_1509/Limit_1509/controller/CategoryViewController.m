//
//  CategoryViewController.m
//  Limit_1509
//
//  Created by block on 15/7/31.
//  Copyright (c) 2015年 whh. All rights reserved.
//


#import "CategoryViewController.h"
#import "CategoryItem.h"
#import "CategoryCell.h"
@interface CategoryViewController ()<UITableViewDataSource,UITableViewDelegate,MyDownLoaderDelegate>
{
    UITableView *_tbView;
    
    NSMutableArray *_dataArray;
}
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMyNav];
    [self createTableView];
    _dataArray = [NSMutableArray array];
    [self downloadData];
}

- (void)createMyNav
{
    UIButton *backBtn = [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"返回" target:self action:@selector(backAction:) isLeft:YES];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:self.titleString];
    
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 375, 667-64-49) style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView ];
}

- (void)downloadData
{
    
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    [downloader downloadWithUrlString:self.urlString];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - MyDownloader代理
- (void)downloader:(MyDownloader *)downloader failWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)downloaderFinish:(MyDownloader *)downloader
{
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = result;
        for (NSDictionary *cateDict in dict[@"category"]) {
            //第一个全部的数据不需要
            NSNumber *n = cateDict[@"categoryId"];
            if (n.integerValue == 0 ) {
                continue;
            }
            CategoryItem *cItem = [[CategoryItem alloc]init];
            [cItem setValuesForKeysWithDictionary:cateDict];
            [_dataArray addObject:cItem];
        }
    }
    [_tbView reloadData];
}

#pragma mark - UITableView协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cateCellId";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CategoryCell" owner:nil options:nil]lastObject];
    }
    CategoryItem * cateItem = _dataArray[indexPath.row];
    [cell configItem:cateItem];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryItem *cItem = _dataArray[indexPath.row];
    if (self.delegate) {
        [self.delegate didSelectCateId:cItem.categoryId titleString:cItem.categoryName];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
// Dispose of any resources that can be recreated.

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
