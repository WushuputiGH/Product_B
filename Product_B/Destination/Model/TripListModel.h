//
//  TripListModel.h
//  Product_B
//
//  Created by by wushuputi on 16/7/14.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Trip.h"
#import "Spot.h"
#import "Waypoint.h"

/**
 *  该类记录了针对每一个景点的trip记录(原创)
 */
@interface TripListModel : NSObject

+ (TripListModel *)shareTripListModel;

@property (nonatomic, strong, readwrite) NSString *message;
@property (nonatomic, strong, readwrite) NSString *statue;
@property (nonatomic, strong, readwrite) NSNumber *next_start;
@property (nonatomic, strong, readwrite) NSMutableArray *trips;


- (void)requstMoreData:(NSDictionary *)jsonDic;

@end
