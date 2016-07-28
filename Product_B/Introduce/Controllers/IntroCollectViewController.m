//
//  IntroCollectViewController.m
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroCollectViewController.h"
#import "IntroCollectionViewCell.h"
#import "IntroStoryCollectModel.h"
#import "IntroStoryDetailViewController.h"

@interface IntroCollectViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectV;
@property (nonatomic, strong) NSMutableArray *modelArray;


@end

@implementation IntroCollectViewController

#pragma mark -- 属性懒加载
- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

#pragma mark 数据请求
- (void)requestData
{
    [YRequestManager requestWithUrlString:KIntroStoryURL parDic:nil requestType:RequestGET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
//        self.modelArray = [IntroStoryCollectModel storyCollectModelConfigureJsonDic:dic];
//        [self.collectV reloadData];
        
        NSMutableArray *array = [IntroStoryCollectModel storyCollectModelConfigureJsonDic:dic];
        NSArray *allId = [self.modelArray valueForKeyPath:@"spot_id"];
        
        NSMutableArray *allIdString = [NSMutableArray array];
        
        for (NSNumber *theId in allId)
        {
            NSString *theIdString = theId.description;
            [allIdString addObject:theIdString];
        }
        
        for (IntroStoryCollectModel *model in array)
        {
            NSString *idString = model.spot_id.description;
            
            if (![allIdString containsObject:idString])
            {
                [self.modelArray addObject:model];
            }
            
        }
        
        
        [self.collectV reloadData];
        
        [self.collectV.mj_header endRefreshing];
        
        
    
    } error:^(NSError *error) {
    
    }];
}

#pragma mark 加载更多数据
- (void)reloadMoreData
{
    [YRequestManager requestWithUrlString:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/new_trip/spot/hot/list/?start=%ld", self.modelArray.count] parDic:nil requestType:RequestGET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *array = [IntroStoryCollectModel storyCollectModelConfigureJsonDic:dic];
        
        for (IntroStoryCollectModel *model in array)
        {
            if (![self.modelArray containsObject:model])
            {
                [self.modelArray addObject:model];
            }
            
            //            [self.modelArray addObject:model];
        }
        
        [self.collectV reloadData];
        [self.collectV.mj_footer endRefreshing];
        
    } error:^(NSError *error) {
        
    }];
}


- (void)initCollectView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((KScreenWidth - 10 - 10) / 2.0, (KScreenWidth - 8) / 2.0);

    self.collectV = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 2, KScreenWidth - 10, KScreenHeight - 64 - 2) collectionViewLayout:layout];
    self.collectV.dataSource = self;
    self.collectV.delegate = self;
    self.collectV.backgroundColor = KCOLOR(255, 255, 255);

    [self.view addSubview:self.collectV];
    
    [self.collectV registerNib:[UINib nibWithNibName:@"IntroCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self requestData];
    
    self.view.backgroundColor = KCOLOR(255, 255, 255);
    
    self.navigationItem.title = @"精彩故事";
    self.navigationController.navigationBar.barTintColor = KCOLOR(80, 225, 230);
    self.navigationController.navigationBar.translucent = NO;
    
    [self initCollectView];
    
    self.collectV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requestData];
    }];
    
    [self.collectV.mj_header beginRefreshing];

    
    self.collectV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self reloadMoreData];
    }];
    
    
    
    // Do any additi onal setup after loading the view.
}

#pragma mark collectview datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntroStoryCollectModel *model = self.modelArray[indexPath.row];
    IntroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    
    [cell storyCellConfigureCollectModel:model];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntroStoryCollectModel *model = self.modelArray[indexPath.row];
    IntroStoryDetailViewController *storyVC = [[IntroStoryDetailViewController alloc] init];
    storyVC.model = model;
    
    storyVC.naviName = model.user[@"name"];
//    storyVC.model.name = model.user[@"name"];
//    storyVC.model.text = model.text;
//    storyVC.model.avatar_l = model.user[@"avatar_l"];
    storyVC.isMain = NO;
    
    [self.navigationController pushViewController:storyVC animated:YES];
}





@end
