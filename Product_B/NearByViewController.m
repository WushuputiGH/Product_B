//
//  NearByViewController.m
//  Product_B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 H. All rights reserved.
//

#import "NearByViewController.h"
#import "NearByHeaderTitleView.h"
#import "NearByNavigationBar.h"
#import <MapKit/MapKit.h>


@interface NearByViewController ()<UIScrollViewDelegate, CLLocationManagerDelegate>

//NearByTypeAll = 0, // 所有
//NearByTypeRestaurant = 5, // 餐厅
//NearByTypeShop = 6, // 购物
//NearByTypeHotel = 10, // 住宿
//NearByTypeScenic = 11, // 风景点
//NearByTypeEntertainment = 21 // 休闲娱乐

@property (nonatomic, strong)NearByTableViewController *nearByAllVC; // 全部
@property (nonatomic, strong)NearByTableViewController *nearByTypeScenic; // 景点
@property (nonatomic, strong)NearByTableViewController *nearByTypeHotel; // 住宿
@property (nonatomic, strong)NearByTableViewController *nearByTypeRestaurant; //餐厅
@property (nonatomic, strong)NearByTableViewController *nearByTypeEntertainment; // 休闲娱乐
@property (nonatomic, strong)NearByTableViewController *nearByTypeShop; // 购物

@property (nonatomic, strong)UIScrollView *theScrollView;
@property (nonatomic, assign)CGFloat screenWidth;
@property (nonatomic, assign)CGFloat screenHeight;

@property (nonatomic, assign)NearByNavigationBar *nearByNavigationBar;
@property (nonatomic, strong)UIScrollView *nearByNavigationScrollView;

@property (nonatomic, strong)NearByHeaderTitleView *nearByHeaderView;

@property (nonatomic, assign)NSInteger index; //用来标示是哪一个类型

#pragma mark ---定位服务---

@property (nonatomic, strong)CLLocationManager *locationManager;
// 当前位置坐标
@property (nonatomic, strong)CLLocation *location;

// 重新定位的buttton
@property (nonatomic, strong)UIButton *reLocationButton;

@end

@implementation NearByViewController


- (NearByNavigationBar *)nearByNavigationBar{
    if (!_nearByNavigationBar) {
        _nearByNavigationBar = [[[NSBundle mainBundle] loadNibNamed:@"NearByNavigationBar" owner:nil options:nil] firstObject];
        _nearByNavigationBar.frame = CGRectMake(0, 0, 540, 44);
    }
    return _nearByNavigationBar;
}


- (UIScrollView *)nearByNavigationScrollView{
    if (!_nearByNavigationScrollView) {
        _nearByNavigationScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth, 44)];
        _nearByNavigationScrollView.contentSize = CGSizeMake(self.screenWidth + 450, 44);
        [_nearByNavigationScrollView addSubview:self.nearByNavigationBar];
        
        _nearByNavigationScrollView.showsHorizontalScrollIndicator = NO;
        _nearByNavigationScrollView.showsVerticalScrollIndicator = NO;
//        _nearByNavigationScrollView.backgroundColor = [UIColor colorWithRed:250.0 / 255 green:102.0 / 255 blue:102.0 / 255 alpha:1];
        _nearByNavigationScrollView.backgroundColor = KLightGreen;
        
        for (int i = 100; i < 106; i ++) {
            UIButton *button = [_nearByNavigationBar viewWithTag: i ];
            [button addTarget:self action:@selector(changeIndex:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
    }
    return _nearByNavigationScrollView;
}



- (UIScrollView *)theScrollView{
    if (!_theScrollView) {
        _theScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, _screenWidth, _screenHeight)];
        _theScrollView.pagingEnabled = YES;
        _theScrollView.contentSize = CGSizeMake(_screenWidth * 6, _screenHeight - 64);
        _theScrollView.showsHorizontalScrollIndicator = NO;
        _theScrollView.showsVerticalScrollIndicator = NO;
        _theScrollView.delegate = self;
        _theScrollView.backgroundColor = KLightGreen;
        
        
    }
    return _theScrollView;
}


- (NearByTableViewController *)nearByAllVC{
    if (!_nearByAllVC) {
        _nearByAllVC = [[NearByTableViewController alloc] init];
        _nearByAllVC.category = NearByTypeAll;
        _nearByAllVC.theId = self.theId;
        _nearByAllVC.theType = self.theType;
        _nearByAllVC.sortType = self.sortType;
        _nearByAllVC.isNotHaveTabBar = self.isNotHaveTabBar;
        _nearByAllVC.location = self.location;
    }
    return _nearByAllVC;
}

- (NearByTableViewController *)nearByTypeScenic{
    if (!_nearByTypeScenic) {
        _nearByTypeScenic = [[NearByTableViewController alloc] init];
        _nearByTypeScenic.category = NearByTypeScenic;
        _nearByTypeScenic.theId = self.theId;
        _nearByTypeScenic.theType = self.theType;
        _nearByTypeScenic.sortType = self.sortType;
        _nearByTypeScenic.isNotHaveTabBar = self.isNotHaveTabBar;
        _nearByTypeScenic.location = self.location;
    }
    return _nearByTypeScenic;
}

- (NearByTableViewController *)nearByTypeHotel{
    if (!_nearByTypeHotel) {
        _nearByTypeHotel = [[NearByTableViewController alloc] init];
        _nearByTypeHotel.category = NearByTypeHotel;
        _nearByTypeHotel.theId = self.theId;
        _nearByTypeHotel.theType = self.theType;
        _nearByTypeHotel.sortType = self.sortType;
        _nearByTypeHotel.isNotHaveTabBar = self.isNotHaveTabBar;
        _nearByTypeHotel.location = self.location;
    }
    return _nearByTypeHotel;
}

- (NearByTableViewController *)nearByTypeRestaurant{
    if (!_nearByTypeRestaurant) {
        _nearByTypeRestaurant = [[NearByTableViewController alloc] init];
        _nearByTypeRestaurant.category = NearByTypeRestaurant;
        _nearByTypeRestaurant.theId = self.theId;
        _nearByTypeRestaurant.theType = self.theType;
        _nearByTypeRestaurant.sortType = self.sortType;
        _nearByTypeRestaurant.isNotHaveTabBar = self.isNotHaveTabBar;
        _nearByTypeRestaurant.location = self.location;
    }
    return _nearByTypeRestaurant;
}
- (NearByTableViewController *)nearByTypeEntertainment{
    if (!_nearByTypeEntertainment) {
        _nearByTypeEntertainment = [[NearByTableViewController alloc] init];
        _nearByTypeEntertainment.category = NearByTypeEntertainment;
        _nearByTypeEntertainment.theId = self.theId;
        _nearByTypeEntertainment.theType = self.theType;
        _nearByTypeEntertainment.sortType = self.sortType;
        _nearByTypeEntertainment.isNotHaveTabBar = self.isNotHaveTabBar;
        _nearByTypeEntertainment.location = self.location;
    }
    return _nearByTypeEntertainment;
}

- (NearByTableViewController *)nearByTypeShop{
    if (!_nearByTypeShop) {
        _nearByTypeShop = [[NearByTableViewController alloc] init];
        _nearByTypeShop.category = NearByTypeShop;
        _nearByTypeShop.theId = self.theId;
        _nearByTypeShop.theType = self.theType;
        _nearByTypeShop.sortType = self.sortType;
        _nearByTypeShop.isNotHaveTabBar = self.isNotHaveTabBar;
        _nearByTypeShop.location = self.location;
    }
    return _nearByTypeShop;
}


- (NearByHeaderTitleView *)nearByHeaderView{
    if (!_nearByHeaderView) {
        _nearByHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"NearByHeaderTitleView" owner:nil options:nil] firstObject];
        _nearByHeaderView.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64);
    }
    return _nearByHeaderView;
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

- (UIButton *)reLocationButton{
    
    if(!_reLocationButton){
        _reLocationButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_reLocationButton addTarget:self action:@selector(reLocation:) forControlEvents:(UIControlEventTouchUpInside)];
        _reLocationButton.frame = CGRectMake(0, 0, 150, 50);
        [_reLocationButton setTitle:@"重新定位" forState:(UIControlStateNormal)];
        
        [_reLocationButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _reLocationButton.titleLabel.font = [UIFont systemFontOfSize:20];
        
        _reLocationButton.layer.cornerRadius = 10;
        _reLocationButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _reLocationButton.layer.borderWidth = 0.5;
        _reLocationButton.clipsToBounds = YES;
        
        _reLocationButton.center = self.view.center;
        // 初始的时候是隐藏
        _reLocationButton.hidden = YES;
    }
    
    return _reLocationButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KLightGreen;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;

    
    // 建立scrollerview
    [self.view addSubview:self.theScrollView];
   
    // 将重新定位按钮添加到view上
    [self.view addSubview:self.reLocationButton];
    
// 定位服务, 成功之后, 添加nearByTableVC
    [self.locationManager requestLocation];

    
   // 添加自定义的导航视图
    [self.view addSubview:self.nearByNavigationScrollView];
    
    self.index = 0;
    [self.navigationController.navigationBar addSubview:self.nearByHeaderView];
    
    // 将rightBarButtonItem设置为nil;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:self action:@selector(back:)];
    
    if (self.isNotHaveTabBar) {
        // 若果没有底部的tabbar, 那么添加一个button
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        backButton.tintColor = [UIColor whiteColor];
        [backButton setImage:[UIImage imageNamed:@"arrow"] forState:(UIControlStateNormal)];
        backButton.frame = CGRectMake(10, 20, 44, 44);
        [self.nearByHeaderView addSubview:backButton];
        [backButton addTarget:self action:@selector(back:) forControlEvents:(UIControlEventTouchUpInside)];
        
        // 更改nearByHeaderView的标题, 变成热门
        [self.nearByHeaderView.theButton setTitle:@"热门" forState:(UIControlStateNormal)];
        
    }
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.nearByNavigationScrollView.hidden = YES;
    self.nearByHeaderView.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.nearByNavigationScrollView.hidden = NO;
    
    self.nearByHeaderView.hidden = NO;

}


- (void)addNearByTableView{
    
    [self.theScrollView addSubview:self.nearByAllVC.view];
    self.nearByAllVC.view.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
    [self addChildViewController:self.nearByAllVC];
    
    [self.theScrollView addSubview:self.nearByTypeScenic.view];
    self.nearByTypeScenic.view.frame = CGRectMake(_screenWidth, 0, _screenWidth, _screenHeight);
    [self addChildViewController:self.nearByTypeScenic];
    
    [self.theScrollView addSubview:self.nearByTypeHotel.view];
    self.nearByTypeHotel.view.frame = CGRectMake(_screenWidth * 2, 0, _screenWidth,  _screenHeight);
    [self addChildViewController:self.nearByTypeHotel];
    
    [self.theScrollView addSubview:self.nearByTypeRestaurant.view];
    self.nearByTypeRestaurant.view.frame = CGRectMake(_screenWidth * 3, 0, _screenWidth, _screenHeight);
    [self addChildViewController:self.nearByTypeRestaurant];
    
    [self.theScrollView addSubview:self.nearByTypeEntertainment.view];
    self.nearByTypeEntertainment.view.frame = CGRectMake(_screenWidth * 4 , 0, _screenWidth, _screenHeight);
    [self addChildViewController:self.nearByTypeEntertainment];
    
    [self.theScrollView addSubview:self.nearByTypeShop.view];
    self.nearByTypeShop.view.frame = CGRectMake(_screenWidth * 5, 0, _screenWidth, _screenHeight);
    [self addChildViewController:self.nearByTypeShop];
    
}



- (void)setIndex:(NSInteger)index{
    _index = index;
    
    [self.theScrollView setContentOffset:CGPointMake(index * self.screenWidth, 0) animated:YES];
    

    
    // 将显示的界面标题字体放大, 其他字体恢复
    for (int i = 0; i < 6; i++) {
        UIButton *button = [self.nearByNavigationBar viewWithTag:100 + i];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    // 获取对应button
    UIButton *button = [self.nearByNavigationBar viewWithTag:(100 + index)];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    
    CGRect frame = button.frame;
    // 设置导航scrollview的偏移量
    CGFloat offsetX = frame.origin.x;
    [self.nearByNavigationScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
    
    
    
}


#pragma mark ---scrollView的delegate----
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 获取属于哪个界面
    NSInteger index = self.theScrollView.contentOffset.x / self.screenWidth;
    self.index = index;
    
}



- (void)changeIndex:(UIButton *)button{
    
    NSInteger index = button.tag - 100;
    self.index = index;
    
}


#pragma mark ----返回按钮, 用户pop----

- (void)back:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ---定位服务----

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    // 定位成功之后, 获取当前位置信息
    self.location = [locations lastObject];
    self.reLocationButton.hidden = YES;
    
    // 将nearBytableView添加
    [self addNearByTableView];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
   
    // 定位失败
    self.reLocationButton.hidden = NO;
    
    NSLog(@"%@", error.description);
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
        [self locationErrorAleartWith:@"未开启定位"];
//        [manager requestWhenInUseAuthorization];
        
    }else{
        if (error.code == kCLErrorDenied) {
            // 定位服务被拒接
            [self locationErrorAleartWith:@"定位功能被禁用"];
        }else{
            [self locationErrorAleartWith:@"定位失败, 稍后再试"];
        }
    }
    
 
    
    [manager stopUpdatingLocation];
    
}

#pragma mark ----定位失败执行的方法-----


- (void)locationErrorAleartWith:(NSString *)errorString{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"定位失败" message:errorString preferredStyle:(UIAlertControllerStyleAlert)];
    

    
    
    if ([errorString isEqualToString:@"定位功能被禁用"] || [errorString isEqualToString:@"未开启定位"] ) {
        
        UIAlertAction *turnSet= [UIAlertAction actionWithTitle:@"去设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            if ([errorString isEqualToString:@"定位功能被禁用"]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        
            if ([errorString isEqualToString:@"未开启定位"]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
            }
             [alertVC dismissViewControllerAnimated:YES completion:nil];
            
        }];
        [alertVC addAction:turnSet];
    }
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"稍后" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
}


#pragma mark ---重新定位的方法---
- (void)reLocation:(UIButton *)button{
    
    [self.locationManager requestLocation];
    button.hidden = YES;
    
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
