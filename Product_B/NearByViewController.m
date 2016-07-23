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
@interface NearByViewController ()<UIScrollViewDelegate>

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
        _nearByNavigationScrollView.backgroundColor = [UIColor colorWithRed:250.0 / 255 green:102.0 / 255 blue:102.0 / 255 alpha:1];
        
        for (int i = 100; i < 106; i ++) {
            UIButton *button = [_nearByNavigationBar viewWithTag: i ];
            [button addTarget:self action:@selector(changeIndex:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
    }
    return _nearByNavigationScrollView;
}



- (UIScrollView *)theScrollView{
    if (!_theScrollView) {
        _theScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, _screenWidth, _screenHeight)];
        _theScrollView.pagingEnabled = YES;
        _theScrollView.contentSize = CGSizeMake(_screenWidth * 6, _screenHeight - 64);
        _theScrollView.showsHorizontalScrollIndicator = NO;
        _theScrollView.showsVerticalScrollIndicator = NO;
        _theScrollView.delegate = self;
        
        
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;

    
    // 建立scrollerview
    [self.view addSubview:self.theScrollView];
   
    [self addNearByTableView];
    
   // 添加自定义的导航视图
    [self.view addSubview:self.nearByNavigationScrollView];
    
    self.index = 0;
    [self.navigationController.navigationBar addSubview:self.nearByHeaderView];
    
    
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
