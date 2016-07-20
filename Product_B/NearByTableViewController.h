//
//  NearByTableViewController.h
//  Product_B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearByListModel.h"

typedef NS_ENUM(NSInteger, NearByType) {
    NearByTypeAll = 0, // 所有
    NearByTypeRestaurant = 5, // 餐厅
    NearByTypeShop = 6, // 购物
    NearByTypeHotel = 10, // 住宿
    NearByTypeScenic = 11, // 风景点
    NearByTypeEntertainment = 21 // 休闲娱乐
};

/**
 *  定义一个枚举变量, 用于记录是第一次进行网络请求, 还是下拉刷新, 上拉加载更多
 */
typedef NS_ENUM(NSInteger, DataRequestType) {
    DataRequestTypeFirst,
    DataRequestTypeRefresh,
    DataRequestTypeMore
};


typedef NS_ENUM(NSInteger, SortType) {
    SortTypeNone,
    SortTypeDefault,
    SortTypeDistance
};

@interface NearByTableViewController : UIViewController

// tabelview的类别, category = 0, 表示全部
@property (nonatomic, assign, readwrite)NearByType category;

// tabelView使用的model数组
@property (nonatomic, strong, readwrite) NearByListModel *nearByListModel;

@property (nonatomic, strong, readwrite) UITableView *nearByTableView;


// 定位管理
@property (nonatomic, strong)CLLocationManager *locationManager;

// 当前位置坐标
@property (nonatomic, strong)CLLocation *location;

@property (nonatomic, assign)DataRequestType dataRequestType;


@property (nonatomic, strong, readwrite) NSString *theId;
@property (nonatomic, strong, readwrite) NSNumber *theType;
@property (nonatomic, assign, readwrite) SortType sortType;


@end
