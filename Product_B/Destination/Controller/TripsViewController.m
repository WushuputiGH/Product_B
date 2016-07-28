//
//  TripsViewController.m
//  Product_B
//
//  Created by by wushuputi on 16/7/14.
//  Copyright © 2016年 H. All rights reserved.
//

#import "TripsViewController.h"
#import "TripListModel.h"
#import "TripsTableViewCell.h"
#import "ReviewListModel.h"
#import "TripsTableViewConatroller.h"
#import "ReviewViewController.h"

typedef NS_ENUM(NSInteger, TableViewType) {
    TableViewTypeTrip, // 原创
    TableViewTypeReview // 点评
};



@interface TripsViewController ()


@property (nonatomic, strong)UISegmentedControl *segmentedControl;

@property (nonatomic, assign)TableViewType tableViewType; // tableView的类型: 显示原创还是点评
@property (nonatomic, assign)DataRequestType dataRequestType; // 数据请求的类型, 第一次请求, 下拉刷新, 上拉加载更多

@property (nonatomic, strong)TripsTableViewConatroller *tripsTableVC;
@property (nonatomic, strong)ReviewViewController *reviewVC;


@end

@implementation TripsViewController

- (UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        
     
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"原创", @"点评"]];
        
        _segmentedControl.selectedSegmentIndex = 0;
        [_segmentedControl addTarget:self action:@selector(chooseTable:) forControlEvents:(UIControlEventValueChanged)];

    }
    return _segmentedControl;
}


- (TripsTableViewConatroller *)tripsTableVC{
    if (!_tripsTableVC) {
        _tripsTableVC = [[TripsTableViewConatroller alloc] init];
        _tripsTableVC.theId = self.theId;
    }
    
    return _tripsTableVC;
    
}

- (ReviewViewController *)reviewVC{
    if (!_reviewVC) {
        _reviewVC = [[ReviewViewController alloc] init];
        _reviewVC.theId = self.theId;
        _reviewVC.type = self.type;
        
    }
    return _reviewVC;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableViewType = TableViewTypeTrip;
    
    [self.view addSubview:self.tripsTableVC.view];
    [self addChildViewController:self.tripsTableVC];
    
    [self.view addSubview:self.reviewVC.view];
    [self addChildViewController:self.reviewVC];
    self.reviewVC.view.hidden = YES;
    
    
    [self.navigationController.navigationBar addSubview:self.segmentedControl];
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.segmentedControl.frame = CGRectMake(width/2 - 50, 7, 100, 30);
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemReply) target:self action:@selector(back:)];
    self.navigationController.navigationBar.translucent = NO;
 
}



#pragma mark ---实现更改tableView的方法

- (void)chooseTable: (UISegmentedControl *)segmentedControl{
    if (segmentedControl.selectedSegmentIndex == 0) {
        self.tripsTableVC.view.hidden = NO;
        self.reviewVC.view.hidden = YES;
    }else{
        self.tripsTableVC.view.hidden = YES;
        self.reviewVC.view.hidden = NO;
    }
}


#pragma mark ---返回----
- (void)back:(UIBarButtonItem *)button{
    [self.segmentedControl removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
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
