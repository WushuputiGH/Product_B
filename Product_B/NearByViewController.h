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


@end
