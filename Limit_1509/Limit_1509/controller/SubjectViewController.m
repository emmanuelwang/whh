
//
//  SubjectViewController.m
//  Limit_1509
//
//  Created by block on 15/7/27.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "SubjectViewController.h"
#import "SubjectCell.h"
#import "SubjectItem.h"
#import "DetailViewController.h"
@interface SubjectViewController ()<MyDownLoaderDelegate,SubjectCellDelegate>

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMyNav];
    [self downloadData];
}

- (void)createMyNav
{
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"专题"];
    _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)downloadData
{
    _isLoading = YES;
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    NSString *urlString = [NSString stringWithFormat:kSubjectUrl,_currentPage];
    [downloader downloadWithUrlString:urlString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView协议
- (void)downloader:(MyDownloader *)downloader failWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)downloaderFinish:(MyDownloader *)downloader
{
    if (_currentPage == 1) {
        [_dataArray removeAllObjects];
    }
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSArray class]]) {
        NSArray *array = result;
        for (NSDictionary *subjuectDict in array) {
            //创建模型对象
            SubjectItem *sItem = [[SubjectItem alloc]init];
            [sItem setValuesForKeysWithDictionary:subjuectDict];
            
            //应用数据
            NSMutableArray *appArray = [NSMutableArray array];
            for (NSDictionary *appDict in subjuectDict[@"applications"]) {
                AppItem *aItem = [[AppItem alloc]init];
                [aItem setValuesForKeysWithDictionary:appDict];
                [appArray addObject:aItem];
            }
            sItem.appArray = appArray;
            [_dataArray addObject:sItem];
        }
    }
    [_tbView reloadData];
    _isLoading = NO;
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

#pragma mark - UITableView协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *subjectCellId = @"subjectCellId";
    SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:subjectCellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SubjectCell" owner:nil options:nil]lastObject];
    }
    cell.sItem = _dataArray[indexPath.row];
    //cell.delegate = self;
    
    __weak SubjectViewController *weakSelf = self;
    cell.clickBlock = ^(AppItem *aItem){
        DetailViewController *dVC = [[DetailViewController alloc]init];
        dVC.applicationId = aItem.applicationId;
        weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:dVC animated:YES];
        weakSelf.hidesBottomBarWhenPushed = NO;
    };
    return cell;
}

#pragma mark - MJRefresh
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_isLoading) {
        return;
    }
    if (refreshView == _headerView) {
        _currentPage = 1;
        [self downloadData] ;
    
    }else if (refreshView == _footerView){
        _currentPage ++;
        [self downloadData];
    }
    
}

//#pragma mark - SubjectCellDelegate 协议
//- (void)didSelectedAppItem:(AppItem *)aItem
//{
//    DetailViewController *dVC = [[DetailViewController alloc]init];
//    dVC.applicationId = aItem.applicationId;
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:dVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
