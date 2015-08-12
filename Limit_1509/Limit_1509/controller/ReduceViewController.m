//
//  ReduceViewController.m
//  Limit_1509
//
//  Created by block on 15/7/27.
//  Copyright (c) 2015年 whh. All rights reserved.
//

#import "ReduceViewController.h"
#import "ReduceCell.h"
#import "LimitModel.h"
#import "SearchViewController.h"
#import "DetailViewController.h"
#import "CategoryViewController.h"
#import "SettingViewController.h"
@interface ReduceViewController ()<MyDownLoaderDelegate,UISearchBarDelegate,CategoryViewControllerDelegate>
@property (nonatomic , strong) NSString *cateId;
    //标题控件
@property (nonatomic , strong) UILabel *titleLabel;
@end

@implementation ReduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMyNav];
    [self downloadData];
    [self createSearchBar];
}

- (void)createSearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
    searchBar.delegate = self;
    searchBar.placeholder = @"800万应用搜搜看";
    _tbView.tableHeaderView = searchBar;
}

- (void)createMyNav
{
    self.titleLabel = [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"降价"];
    [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"分类" target:self action:@selector(gotoCategory) isLeft:YES];
    [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"设置" target:self action:@selector(gotoSet) isLeft:NO];
}
- (void)gotoCategory
{
    CategoryViewController *cateCtrl = [[CategoryViewController alloc]init];
    cateCtrl.titleString = @"降价分类";
    cateCtrl.urlString = kCategoryReduceUrl;
    cateCtrl.delegate = self;
    [self.navigationController pushViewController:cateCtrl animated:YES];
}

- (void)gotoSet
{
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
- (void)downloadData
{
    //修改下载状态
    _isLoading = YES;
    
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    
    NSString *urlString = [NSString stringWithFormat:kReduceUrl,_currentPage];
    if (self.cateId) {
        urlString = [NSString stringWithFormat:@"%@&category_id=%@",urlString,self.cateId];
    }
    [downloader downloadWithUrlString:urlString];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -MyDownload协议
- (void)downloader:(MyDownloader *)downloader failWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)downloaderFinish:(MyDownloader *)downloader
{
    if (_currentPage == 1) {
        [_dataArray removeAllObjects];
    }
    //解析数据
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = result;
        NSArray *appArray = dict[@"applications"];
        for (NSDictionary *appDict in appArray) {
            //创建模型对象
            LimitModel *model = [[LimitModel alloc]init];
            //kvc设置
            [model setValuesForKeysWithDictionary:appDict];
            //添加到数据源数组中
            [_dataArray addObject:model];
        }
    }
    [_tbView reloadData];
    _isLoading = NO;
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

#pragma mark - UISearchBar 协议
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //显示取消按钮
    searchBar.showsCancelButton = YES;
    UIView *firstSub = [searchBar.subviews firstObject];
    for (UIView *sub in firstSub.subviews) {
        Class cls = NSClassFromString(@"UINavigationButton");
        if ([sub isKindOfClass:cls]) {
            UIButton *btn = (UIButton *)sub;
            //设置文字
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //跳转到搜索结构界面
    SearchViewController *vc = [[SearchViewController alloc]init];
    vc.keyword = searchBar.text;
    vc.type = SearchTypeReduce;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark UITableView协议

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
    static NSString *cellId = @"reduceCellId";
    ReduceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ReduceCell" owner:nil options:nil]lastObject];
    }
    LimitModel *model = _dataArray[indexPath.row];
    [cell configModel:model index:indexPath.row];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LimitModel *model = _dataArray[indexPath.row];
    DetailViewController *dCtrl = [[DetailViewController alloc]init];
    dCtrl.applicationId = model.applicationId;
    [self.navigationController pushViewController:dCtrl animated:YES];
}


#pragma mark MJRefresh协议
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_isLoading) {
        return;
    }
    if (refreshView == _headerView) {
        //下拉刷新
        _currentPage = 1;
        [self downloadData];
    }else if (refreshView == _footerView){
        _currentPage++;
        [self downloadData];
    }
}

#pragma mark - CategoryViewController协议
- (void)didSelectCateId:(NSString *)categoryId titleString:(NSString *)cateName
{
    self.cateId = categoryId;
    self.titleLabel.text = [NSString stringWithFormat:@"降价-%@",cateName];
    
    _currentPage = 1;
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
