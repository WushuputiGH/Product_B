 //
//  NearByTableViewController.m
//  Product_B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 H. All rights reserved.
//




#import "NearByTableViewController.h"
#import "NearByTableViewCell.h"
#import "DestinationViewController.h"
#import "DeatinationDetailModel.h"




// 定义tabelview的大小
#define kFrameOfTabelView CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height - 64 - 49)

@interface NearByTableViewController ()<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>




@end

@implementation NearByTableViewController


- (NearByListModel *)nearByListModel{
    if (!_nearByListModel) {
        _nearByListModel = [[NearByListModel alloc] init];
    }
    return _nearByListModel;
}



- (UITableView *)nearByTableView{
    if (!_nearByTableView) {
        _nearByTableView = [[UITableView alloc] initWithFrame:kFrameOfTabelView style:(UITableViewStylePlain)];
        _nearByTableView.dataSource = self;
        _nearByTableView.delegate =self;
        _nearByTableView.rowHeight = 150;
        _nearByTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        //注册cell
        [_nearByTableView registerNib:[UINib nibWithNibName:@"NearByTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"nearByTableViewCell"];
    }
    return _nearByTableView;
}


- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        // 如果用户没有开启定位服务, 请求开启
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
            // 向设备申请"程序使用中时,使用定位功能"
            [_locationManager requestWhenInUseAuthorization];
        }
        // 设置没间隔10米定位一次
        _locationManager.distanceFilter = 10;
        // 设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;

    }
    return _locationManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    // 首先需要添加tabelView
    [self.view addSubview:self.nearByTableView];
    
    // 设置数据请求类型
    self.dataRequestType = DataRequestTypeFirst;
    
    // 给tabelView添加MjRefresh
    __weak typeof(self) weakSelf = self;
    self.nearByTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 当下拉时候, 刷新
        // 注意: 下拉刷新的时候重新进行定位, 刷新数据, 因此也相当于是第一次请求
        weakSelf.dataRequestType = DataRequestTypeRefresh;
        [weakSelf.locationManager requestLocation];
        
    }];
    
    self.nearByTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.dataRequestType = DataRequestTypeMore;
        [weakSelf requestData];
    }];
    
    // 请求数据
    // 刚开始的时候, 就执行定位
    /**
     *  注意定位信息是异步的, 一次网络请求数据应该放在位置信息更新之后进行
     */
    [self.locationManager requestLocation];
    
}


#pragma mark ---刷新数据------

- (NSString *)getUrl{
    //"http://api.breadtrip.com/place/pois/nearby/?category=11&start=0&count=20&latitude=31.129695&longitude=121.283478"
    // 获取最新数据的接口, category是分类,latitude=%f&longitude=%f分别是纬度和经度
    // 获取需要进行get请求的url
    NSInteger start = 0; // 如果是第一次加载, 或者刷新, start = 0;
    if (self.dataRequestType == DataRequestTypeMore) {
        // 如果是上拉加载更多, 那么start就应该是目前存在的数量
        start = self.nearByListModel.nearByList.count;
    }
    NSString *urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/place/pois/nearby/?category=%ld&start=%ld&count=20&latitude=%f&longitude=%f", _category, start, self.location.coordinate.latitude, self.location.coordinate.longitude];
    NSLog(@"%@", urlString);
    return urlString;
    
}


#pragma mark ---重写geturl的方法---
- (NSString *)getUrlWithSort{
    //http://api.breadtrip.com/destination/place/1/US/pois/sights/?start=0&count=20&sort=default&shift=false&latitude=31.13023401476414&longitude=121.28393616861723
    // 获取最新数据的接口, category是分类,latitude=%f&longitude=%f分别是纬度和经度
    // 获取需要进行get请求的url
    NSInteger start = 0; // 如果是第一次加载, 或者刷新, start = 0;
    if (self.dataRequestType == DataRequestTypeMore) {
        // 如果是上拉加载更多, 那么start就应该是目前存在的数量
        start = self.nearByListModel.nearByList.count;
    }
    
    NSString *categoryString = nil;
    switch (self.category) {
        case NearByTypeAll:
            categoryString = @"all";
            break;
        case NearByTypeRestaurant:
            categoryString = @"restaurant";
            break;
        case NearByTypeScenic:
            categoryString = @"sight";
            break;
        case NearByTypeHotel:
            categoryString = @"hotel";
            break;
        case NearByTypeEntertainment:
            categoryString = @"experience";
            break;
        case NearByTypeShop:
            categoryString = @"mall";
            break;
        default:
            break;
    }
    
    if (self.sortType == SortTypeDefault) {
        NSString *urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/pois/%@/?start=%ld&count=20&sort=default&shift=false&latitude=%f&longitude=%f", self.theType, self.theId,categoryString, start, self.location.coordinate.latitude, self.location.coordinate.longitude];
        NSLog(@"%@", urlString);
        return urlString;
    }else{
        NSString *urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/pois/%@/?start=%ld&count=20&sort=distance&shift=false&latitude=%f&longitude=%f", self.theType, self.theId,categoryString, start, self.location.coordinate.latitude, self.location.coordinate.longitude];
        NSLog(@"%@", urlString);
        return urlString;
    }
}



- (void)requestData{
    
    NSString *urlString = nil;
    if (self.sortType == SortTypeNone) {
         urlString = [self getUrl];
    }else{
        urlString = [self getUrlWithSort];
    }
   
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        
        // 使用json解析, 获取请求下来的数组
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        // 赋值model
        if (self.dataRequestType != DataRequestTypeMore) {
            if (self.dataRequestType == DataRequestTypeRefresh) {
                // 如果是下拉刷新数据
                // 注意: 下拉刷新的时候重新进行定位, 刷新数据, 因此也相当于是第一次请求
//                [self.nearByListModel getRefreshDataWithJsonDic:jsonDic];
                [self.nearByListModel getFristDataWithJsonDic:jsonDic];
                [self.nearByTableView.mj_header endRefreshing];
            }else{
                [self.nearByListModel getFristDataWithJsonDic:jsonDic];
            }
        }else{
            // 如果是上拉加载更多
            [self.nearByListModel getMoreDataWithJsonDic:jsonDic];
            [self.nearByTableView.mj_footer endRefreshing];
        }
        
        
        // 刷洗tabelView
        [self.nearByTableView reloadData];
        
    } error:^(NSError *error) {
        NSLog(@"NearByTableView数据请求有问题");
    }];
}


#pragma mark ---tableView的代理方法----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nearByListModel.nearByList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearByTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearByTableViewCell" forIndexPath:indexPath];
    
    // 首先获取neatByitem
    NearByItem *nearByItem = self.nearByListModel.nearByList[indexPath.row];
    // 配置cell
    [cell cellConfigureWith: nearByItem];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 首先获取neatByitem
    NearByItem *nearByItem = self.nearByListModel.nearByList[indexPath.row];
    // 当点击cell的时候, 配置deatinationmodel的单例
    DestinationViewController *destinationVC = [[DestinationViewController alloc] init];
//    destinationVC.theType = nearByItem.type;
//    destinationVC.theId = nearByItem.nearByItemId;
    destinationVC.nearByItem = nearByItem;
    
//    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:destinationVC];
//    [self presentViewController:navigation animated:YES completion:nil];
    [self.navigationController pushViewController:destinationVC animated:YES];

}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.tabBarController.tabBar.hidden = YES;
}

#pragma mark ---执行定位的代理方法-----
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    // 首先获取位置信息
    self.location = [locations lastObject];
    
    // 获取当前的定位信息之后, 进行数据请求
    [self requestData];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error.description);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
