//
//  SearchViewController.m
//  Limit_1509
//
//  Created by block on 15/7/29.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "SearchViewController.h"
#import "LimitModel.h"
#import "LimitCell.h"
#import "DetailViewController.h"
@interface SearchViewController ()<MyDownLoaderDelegate,UISearchBarDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMyNav];
    [self createSearchBar];
}

- (void)createSearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 375, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"需要什么,搜索一下";
    _tbView.tableHeaderView = searchBar;
}

- (void)createMyNav
{
    UIButton *btn = [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"返回" target:self action:@selector(backAction:) isLeft:YES];
    [btn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"搜索"];
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)downloadData
{
    _isLoading = YES;
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    NSString *urlString = nil;
    if (self.type == SearchTypeLimit) {
        urlString = [NSString stringWithFormat:kLimitSearchUrl,_currentPage,self.keyword];
    }
    else if (self.type == SearchTypeReduce)
    {
        urlString = [NSString stringWithFormat:KReduceSearchUrl,_currentPage,self.keyword];
    }
    else if (self.type == SearchTypeFree)
    {
        urlString = [NSString stringWithFormat:kFreeSearchUrl,_currentPage,self.keyword];
    }
    else if (self.type == SearchTypeHot)
    {
        urlString = [NSString stringWithFormat:kHotSearchUrl,_currentPage,self.keyword];
    }
    [downloader downloadWithUrlString:urlString];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MyDownloader协议
- (void)downloader:(MyDownloader *)downloader failWithError:(NSError *)error
{
    NSLog(@"搜索失败:%@",error);
}

- (void)downloaderFinish:(MyDownloader *)downloader
{
    if (_currentPage == 1) {
        [_dataArray removeAllObjects];
    }
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = result;
        for (NSDictionary *appDict in dict[@"applications"]) {
            LimitModel *model = [[LimitModel alloc]init];
            [model setValuesForKeysWithDictionary:appDict];
            [_dataArray addObject:model];
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"limitCellId";
    LimitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LimitCell" owner:nil options:nil]lastObject];
    }
    LimitModel *model = _dataArray[indexPath.row];
    [cell configModel:model index:indexPath.row cutLength:0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LimitModel *model = _dataArray[indexPath.row];
    DetailViewController *dCtrl = [[DetailViewController alloc]init];
    dCtrl.applicationId = model.applicationId;
    [self.navigationController pushViewController:dCtrl animated:YES];
}

#pragma  mark - MJRefresh协议
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_isLoading) {
        return;
    }
    if (refreshView == _headerView) {
        _currentPage = 1;
        [self downloadData];
    }else if (refreshView == _footerView){
        _currentPage++;
        [self downloadData];
    }
}

#pragma mark - UISearchBar

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    UIView *firstSub = [searchBar.subviews lastObject];
    NSArray *subArray = firstSub.subviews;
    for (UIView *sub in subArray) {
        if ([sub isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            UIButton *btn = (UIButton *)sub;
            
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
            
        }
    }
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.keyword = searchBar.text;
    [self downloadData];
    
    
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
