//
//  ReviewViewController.h
//  Product_B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewListModel.h"
#import "ReviewTableViewCell.h"


@interface ReviewViewController : UIViewController


@property (nonatomic, strong, readwrite) NSString *theId;
@property (nonatomic, strong, readwrite) NSNumber *type;


@end
