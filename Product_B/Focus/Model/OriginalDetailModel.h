//
//  OriginalDetailModel.h
//  Product_B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Waypoint.h"
#import "User.h"

@interface Day : NSObject
@property (nonatomic, strong, readwrite) NSString *date;
@property (nonatomic, strong, readwrite) NSNumber *day;
@property (nonatomic, strong, readwrite) NSMutableArray <Waypoint *> *waypoints;

@end

@interface OriginalDetailModel : NSObject

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSNumber *theId;
@property (nonatomic, strong, readwrite) NSString *trackpoints_thumbnail_image;
@property (nonatomic, strong, readwrite) NSString *cover_image;


@property (nonatomic, strong, readwrite) NSNumber *first_day;
@property (nonatomic, strong, readwrite) NSNumber *day_count;
@property (nonatomic, strong, readwrite) NSNumber *mileage;
@property (nonatomic, strong, readwrite) NSNumber *recommendations;

@property (nonatomic, strong, readwrite) NSNumber *flight;
@property (nonatomic, strong, readwrite) NSNumber *mall;
@property (nonatomic, strong, readwrite) NSNumber *sights;
@property (nonatomic, strong, readwrite) NSNumber *restaurant;
@property (nonatomic, strong, readwrite) NSNumber *hotel;

@property (nonatomic, strong, readwrite) NSArray *covered_countries; // 图经国家地区数组, 每一条信息都包含国家地区的id, type,  name, icon
@property (nonatomic, strong, readwrite) User *theUser;



@property (nonatomic, strong, readwrite) NSArray<Day *> *days;


@property (nonatomic, strong, readwrite) NSArray *trackpoints; // 只是用来存放照片信息


@end
