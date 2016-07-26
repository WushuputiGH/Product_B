//
//  NearByViewController.h
//  Product_B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearByTableViewController.h"


@interface NearByViewController : UIViewController

@property (nonatomic, strong, readwrite) NSString *theId;
@property (nonatomic, strong, readwrite) NSNumber *theType;
@property (nonatomic, assign, readwrite) SortType sortType;

/**
 *  定义属性, 用于判断是否有tabBar(即: 从何处跳转)
 */
@property (nonatomic, assign, readwrite) BOOL isNotHaveTabBar;

@end
