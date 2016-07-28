//
//  IntroduceMainViewController.m
//  Product_B
//
//  Created by by wushuputi on 16/7/12.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroduceMainViewController.h"
#import "IntroMainScrollModel.h"
#import "IntroCollectionViewCell.h"
#import "YIntroTableViewCell.h"
#import "IntroMainTableModel.h"
#import "IntroScrollWebViewController.h"
#import "IntroCollectViewController.h"
#import "IntroTableDetailViewController.h"
#import "IntroStoryDetailViewController.h"


@interface IntroduceMainViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *collectView;



@property (nonatomic, strong) NSMutableArray *scrollArray;
@property (nonatomic, strong) NSMutableArray *scrImageArr;
@property (nonatomic, strong) NSMutableArray *collectArray;
@property (nonatomic, strong) NSMutableArray *tableArray;

@property (nonatomic, strong) NSString *next_start; // 定义一个字符串用于存放刷新ID


@end

@implementation IntroduceMainViewController

#pragma mark -- 属性

- (NSMutableArray *)scrollArray
{
    if (!_scrollArray) {
        _scrollArray = [NSMutableArray array];
    }
    return _scrollArray;
}

- (NSMutableArray *)scrImageArr
{
    if (!_scrImageArr) {
        _scrImageArr = [NSMutableArray array];
    }
    return _scrImageArr;
}

- (NSMutableArray *)collectArray
{
    if (!_collectArray) {
        _collectArray = [NSMutableArray array];
    }
    return _collectArray;
}

- (NSMutableArray *)tableArray
{
    if (!_tableArray) {
        _tableArray = [NSMutableArray array];
    }
    return _tableArray;
}

#pragma mark -- 请求数据
- (void)requestData
{
    [YRequestManager requestWithUrlString:KIntroMainURL parDic:nil requestType:RequestPOST finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        // scrollView数据
        self.scrollArray = [IntroMainScrollModel IntroScrollModelConfigureJsonDic:dic];
        for (IntroMainScrollModel *sModel in self.scrollArray)
        {
            [self.scrImageArr addObject:sModel.ImgSrc];
        }
        [self initCycleScrollView];
        
    } error:^(NSError *error) {
         
     }];
}

// collect / table
- (void)requestData1
{
    
    self.next_start = [NSString string];
    
    [YRequestManager requestWithUrlString:KIntroMainCTURL parDic:nil requestType:RequestGET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        self.next_start = dic[@"data"][@"next_start"];

        
        // collectView数据
        self.collectArray = [IntroMainCollectModel collectConfigureJsonDic:dic];
        
        [self.collectView reloadData];
        
        // tableView数据
//        self.tableArray = [IntroMainTableModel tableModelConfigureJsonDic:dic];
        
        NSMutableArray *array = [IntroMainTableModel tableModelConfigureJsonDic:dic];
        for (IntroMainTableModel *model in array)
        {
            [self.tableArray addObject:model];
        }
        
        [self.mainTableView reloadData];
        
        [self.mainTableView.mj_header endRefreshing];
        
    } error:^(NSError *error) {
        
    }];

}

#pragma mark -- 加载更多数据
- (void)reloadMoreData
{
    [self.mainTableView.mj_footer beginRefreshing];
    
    
    [YRequestManager requestWithUrlString:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/index/?next_start=%@", self.next_start] parDic:nil requestType:RequestGET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.next_start = dic[@"data"][@"next_start"];
        NSLog(@"%@", self.next_start);
        
        NSMutableArray *array = [IntroMainTableModel tableModelConfigureJsonDic:dic];
        for (IntroMainTableModel *model in array) {
            [self.tableArray addObject:model];
        }
        //        self.tableArray = [IntroMainTableModel tableModelConfigureJsonDic:dic];
        
        
        [self.mainTableView reloadData];
        [self.mainTableView.mj_footer endRefreshing];
        
    } error:^(NSError *error) {
        
    }];
}


#pragma mark -- scroll、collect、table
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(2, 0, KScreenWidth - 4, KScreenHeight - 64) style:(UITableViewStylePlain)];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        self.mainTableView.tableHeaderView = self.headView;
        
        [self.mainTableView registerNib:[UINib nibWithNibName:@"YIntroTableViewCell" bundle:nil] forCellReuseIdentifier:@"mainTable"];
        
    }
    return _mainTableView;
}

- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 4 , KScreenHeight - 40 + 30)];
        
        UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, (KScreenHeight - 64) / 3.0 + 10, 5, 30)];
        v1.backgroundColor = KCOLOR(0, 255, 0);
        
        
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, (KScreenHeight - 64) / 3.0 + 10, 200, 30)];
        lab1.text = @"每日精选故事";
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 80, (KScreenHeight - 64) / 3.0 + 10, 100, 30)];
        [btn setTitle:@"全部＞" forState:(UIControlStateNormal)];
        [btn setTitleColor:KCOLOR(150, 150, 150) forState:(UIControlStateNormal)];
//        [btn setBackgroundColor:KCOLOR(200, 200, 100)];
        [btn addTarget:self action:@selector(turnTableViewAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [_headView addSubview:v1];
        [_headView addSubview:lab1];
        [_headView addSubview:btn];
        
        UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 64 -10 + 30, 5, 30)];
        v2.backgroundColor = KCOLOR(0, 255, 0);
        
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10, KScreenHeight - 64 - 10 + 30, 200, 30)];
        lab2.text = @"精彩原创&专题";
        
        [_headView addSubview:v2];
        [_headView addSubview:lab2];
    }
    return _headView;
}

- (void)initScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 4, (KScreenHeight - 64) / 3.0)];
//    self.scrollView.backgroundColor = KCOLOR(100, 100, 100);
    [self.headView addSubview:self.scrollView];
}

- (void)initCycleScrollView
{
    CarouselView *carV = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 4, (KScreenHeight - 64) / 3.0) imageURLs:self.scrImageArr];
    [self.scrollView addSubview:carV];
    
    // 点击scroll进行跳转
    carV.imageClick = ^(NSInteger index){
        IntroMainScrollModel *model = self.scrollArray[index];
    
        IntroScrollWebViewController *scrWebVC = [[IntroScrollWebViewController alloc] init];
        scrWebVC.link = model.Link;
        scrWebVC.naviName = model.BannerName;
        scrWebVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:scrWebVC animated:YES];
    };


}

- (void)initCollectView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake((KScreenWidth - 10 - 8) / 2.0, (KScreenWidth - 8) / 2.0);
    
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(2, (KScreenHeight - 64) / 3.0 + 30 + 15, KScreenWidth - 8, (KScreenWidth - 8) / 3.0 * 2 + 20 + 130) collectionViewLayout:layout];
    
    _collectView.dataSource = self;
    _collectView.delegate = self;
    
    self.collectView.backgroundColor = KCOLOR(255, 255, 255);
    [_headView addSubview:_collectView];
        
    [_collectView registerNib:[UINib nibWithNibName:@"IntroCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];

}

#pragma mark --ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"顺便看看-精彩故事-热门游记";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:KCOLOR(255, 255, 255)}];
    
    
//    self.navigationController.navigationBar.barTintColor = KCOLOR(80, 225, 230);
    self.navigationController.navigationBar.barTintColor = KCOLOR(0, 195, 209);

    self.navigationController.navigationBar.translucent = NO;
    
    [self requestData]; // scroll
    [self requestData1]; // collect / table
    [self initScrollView];
    [self initCollectView];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.mainTableView];
    
    
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requestData1];
    }];
    
    [self.mainTableView.mj_header beginRefreshing];
    
    
    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self reloadMoreData];
    }];
    
    
    
    // Do any additional setup after loading the view.
}


#pragma mark -- 点击方法
- (void)turnTableViewAction:(UIButton *)btn
{
    IntroCollectViewController *collectVC = [[IntroCollectViewController alloc] init];
    collectVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:collectVC animated:YES];
}

#pragma mark -- tableView 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 270;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntroMainTableModel *model = self.tableArray[indexPath.row];
    YIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainTable"];
   
    [cell cellConfigureTableModel:model];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntroMainTableModel *model = self.tableArray[indexPath.row];
    
    IntroTableDetailViewController *tableDetailVC = [[IntroTableDetailViewController alloc] init];
    
    tableDetailVC.model = [[IntroTableDetailModel alloc] init];
    tableDetailVC.model.trip_id = model.id;
    tableDetailVC.avatar_l = model.user[@"avatar_l"];
//    tableDetailVC.trackpoints_thumbnail_image = model.
    
    tableDetailVC.navigationItem.title = model.name;
    tableDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tableDetailVC animated:YES];
}


#pragma mark -- collectView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntroMainCollectModel *model = self.collectArray[indexPath.row];
    IntroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    
    [cell cellConfigureCollectModel:model];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntroMainCollectModel *model = self.collectArray[indexPath.row];
    IntroStoryDetailViewController *storyDetailVC = [[IntroStoryDetailViewController alloc] init];
    storyDetailVC.naviName = model.name;
    storyDetailVC.model = [[IntroStoryCollectModel alloc] init];
    storyDetailVC.model = (IntroStoryCollectModel *)model;
    storyDetailVC.avatar_l = model.avatar_l;
    storyDetailVC.isMain = YES;
//    storyDetailVC.model.user[@"avatar_l"] = model.avatar_l;
    storyDetailVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:storyDetailVC animated:YES];
}

#pragma mark -- 刷新操作
- (void)setUpRefresh
{
//    [self.mai]
}


- (void)headerRefreshing
{
    [self requestData];
//    [RequestManager ]
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = YES;
}



@end
