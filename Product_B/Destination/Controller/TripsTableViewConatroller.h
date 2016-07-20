//
//  TripsTableViewConatroller.h
//  Product_B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DataRequestType) {
    DataRequestTypeFirst,
    DataRequestTypeNew,
    DataRequestTypeMore
};
@interface TripsTableViewConatroller : UIViewController

@property (nonatomic, strong, readwrite) NSString *theId;


@end
