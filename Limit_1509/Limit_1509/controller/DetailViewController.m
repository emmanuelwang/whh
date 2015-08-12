//
//  DetailViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailItem.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"
#import "LimitModel.h"
#import "NearButton.h"
#import "PhotoViewController.h"
#import "DBManager.h"
@interface DetailViewController () <MyDownLoaderDelegate>

@property (nonatomic,strong) DetailItem *dItem;

@property (nonatomic,strong) NSMutableArray *nearbyArray;


@end

@implementation DetailViewController

- (NSMutableArray *)nearbyArray
{
    if (_nearbyArray == nil) {
        _nearbyArray = [NSMutableArray array];
    }
    return _nearbyArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.appImageView.hidden = YES;
    [self createMyNav];
    //下载详情信息
    [self downloadData];
    [self downloadNearbyData];
    
    BOOL ret = [[DBManager sharedInstance] isAppFavorite:self.applicationId];
    if (ret) {
        [self.favoriteBtn setTitle:@"已收藏" forState:UIControlStateNormal];
        [self.favoriteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.favoriteBtn.enabled = NO;
    }
}

- (void)downloadNearbyData
{
    MyDownloader *downloader = [[MyDownloader alloc]init];
    downloader.delegate = self;
    downloader.type = 200;
    NSString *urlString = kNearByUrl;
    [downloader downloadWithUrlString:urlString];
}

- (void)createMyNav
{
    UIButton *btn = [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"返回" target:self action:@selector(backAction:) isLeft:YES];
    [btn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    
    //标题
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"应用详情"];
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)shareAction:(id)sender {
}

- (IBAction)favoriteAction:(id)sender
{
    if (self.dItem == nil) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据还没下载完成,请稍后收藏" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    
    CollectItem *cItem = [[CollectItem alloc]init];
    cItem.applicationId = self.dItem.applicationId;
    cItem.name = self.dItem.name;
    cItem.image = self.appImageView.image;
//    DBManager *manager = [DBManager sharedInstance];
//    [manager addCollect:cItem];
    
    [[DBManager sharedInstance] addCollect:cItem];
    [self.favoriteBtn setTitle:@"已收藏" forState:UIControlStateNormal];
    [self.favoriteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.favoriteBtn.enabled = NO;
    
}


- (void)downloadData
{
    MyDownloader *downloader = [[MyDownloader alloc] init];
    downloader.delegate = self;
    downloader.type = 100;
    NSString *urlString = [NSString stringWithFormat:kDetailUrl,self.applicationId];
    [downloader downloadWithUrlString:urlString];
}
- (IBAction)downloadAction:(id)sender
{
    if (self.dItem.itunesUrl) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.dItem.itunesUrl]];
    }
}

//显示附近数据
- (void)showNearbyData
{
    //循环创建按钮
    CGFloat w = 80;
    CGFloat h = 80;
    CGFloat space = 10;
    for (NSInteger i=0; i<self.nearbyArray.count; i++) {
        LimitModel *model = self.nearbyArray[i];
        
        CGRect frame = CGRectMake((w+space)*i, 0, w, h);
        NearButton *btn = [[NearButton alloc]initWithFrame:frame];
        btn.appModel = model;
        btn.tag = 200+i;
        //事件
        [btn addTarget:self action:@selector(clickNearbyBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.nearbyScrollView addSubview:btn];
    }
    CGFloat scrollW = (w+space)*self.nearbyArray.count;
    if (scrollW > self.nearbyScrollView.bounds.size.width) {
        self.nearbyScrollView.contentSize = CGSizeMake(scrollW, 80);
    }else{
        self.nearbyScrollView.contentSize = CGSizeMake(self.nearbyScrollView.bounds.size.width+10, 80);
    }
    self.nearbyScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)clickNearbyBtn:(NearButton *)btn
{
    NSInteger index = btn.tag - 200;
    LimitModel *model = self.nearbyArray[index];
    //跳转到详情界面
    NSLog(@"123");
    DetailViewController *dCtrl = [[DetailViewController alloc]init];
    dCtrl.applicationId = model.applicationId;
    [self.navigationController pushViewController:dCtrl animated:YES];
}
//显示详情的数据
- (void)showDetailData
{
    self.appImageView.hidden = NO;
    //图片
    [self.appImageView sd_setImageWithURL:[NSURL URLWithString:self.dItem.iconUrl]];
    self.nameLabel.text = self.dItem.name;
    self.priceLabel.text = [NSString stringWithFormat:@"原价:%@",self.dItem.currentPrice];
    if ([self.dItem.priceTrend isEqualToString:@"limited"]) {
        self.statusLabel.text = @"限免";
    }else if ([self.dItem.priceTrend isEqualToString:@"free"])
    {
        self.statusLabel.text = @"免费";
    }
    //大小
    self.sizeLabel.text = [NSString stringWithFormat:@"%@MB",self.dItem.fileSize];
    
    self.typeLabel.text = self.dItem.categoryName;
    
    self.rateLabel.text = [NSString stringWithFormat:@"%.1f",self.dItem.starCurrent.floatValue];
    //图片
    CGFloat w = 80;
    CGFloat h = 90;
    for (int i = 0; i < self.dItem.photoArray.count; i ++ ) {
        PhotoItem *pItem = self.dItem.photoArray[i];
        UIImageView *tmpImageView = [MyUtil createImageViewFrame:CGRectMake((w+10) * i, 0, w, h) imageName:nil];
        [tmpImageView sd_setImageWithURL:[NSURL URLWithString:pItem.smallUrl]];
        tmpImageView.userInteractionEnabled = YES;
        tmpImageView.tag = 200+i;
        UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [tmpImageView addGestureRecognizer:g];
        
        [self.imageScrollView addSubview:tmpImageView];
    }
    self.imageScrollView.contentSize = CGSizeMake((w+10)*self.dItem.photoArray.count, h);
    self.descLabel.text = self.dItem.myDescription;
    self.descLabel.numberOfLines = 0;
}


- (void)tapAction:(UITapGestureRecognizer *)g
{
    UIImageView *imageView = (UIImageView *)g.view;
    NSInteger index = imageView.tag - 200;
    
    PhotoViewController *pCtrl = [[PhotoViewController alloc]init];
    pCtrl.index = index;
    pCtrl.photoArray = self.dItem.photoArray;
    pCtrl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:pCtrl animated:YES completion:nil];
}
- (void)downloader:(MyDownloader *)downloader failWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)downloaderFinish:(MyDownloader *)downloader
{
    if (downloader.type == 100) {
        //详情的数据
        id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = result;
        
            //创建模型对象
            self.dItem = [[DetailItem alloc] init];
            [self.dItem setValuesForKeysWithDictionary:dict];
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *photoDict in dict[@"photos"]) {
                PhotoItem *pItem = [[PhotoItem alloc] init];
                [pItem setValuesForKeysWithDictionary:photoDict];
                [array addObject:pItem];
            }
            self.dItem.photoArray = array;
        }
        [self showDetailData];
    }else if(downloader.type == 200){
        id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = result;
            for (NSDictionary *appDict in dict[@"applications"]) {
                LimitModel *model = [[LimitModel alloc]init];
                [model setValuesForKeysWithDictionary:appDict];
                //懒加载的方式一定要调用getter方法
                [self.nearbyArray addObject:model];
            }
        }
        [self showNearbyData];
    }
    //显示数据
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
