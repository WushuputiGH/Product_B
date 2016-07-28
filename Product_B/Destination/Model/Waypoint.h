//
//  Waypoint.h
//  Product_B
//
//  Created by by wushuputi on 16/7/14.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Waypoint : NSObject <NSCoding>

@property (nonatomic, strong, readwrite) NSString *photo;
@property (nonatomic, strong, readwrite) NSData *photoData;


@property (nonatomic, strong, readwrite) NSString *trip_id;
@property (nonatomic, strong, readwrite) NSString *waypointId;
@property (nonatomic, strong, readwrite) NSString *photo_s;
@property (nonatomic, strong, readwrite) NSDictionary *photo_info; // 图片信息:h, w
@property (nonatomic, strong, readwrite) NSString *text;

@property (nonatomic, strong, readwrite) NSString *local_time;
@property (nonatomic, strong, readwrite) NSString *date_added;

@property (nonatomic, strong, readwrite) NSDictionary *location; // 位置信息latitude, lat, lng, longitude

@property (nonatomic, strong, readwrite) NSString *city;
@property (nonatomic, strong, readwrite) NSString *country;



@end
