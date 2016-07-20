//
//  Poi.h
//  Product_B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Poi : NSObject

@property (nonatomic, strong, readwrite) NSString *address;
@property (nonatomic, strong, readwrite) NSString *arrival_type;
@property (nonatomic, strong, readwrite) NSNumber *category;
@property (nonatomic, strong, readwrite) NSString *currency;
@property (nonatomic, strong, readwrite) NSString *date_added;
@property (nonatomic, strong, readwrite) NSString *Poidescription;
@property (nonatomic, strong, readwrite) NSString *extra1;
@property (nonatomic, strong, readwrite) NSString *fee;
@property (nonatomic, strong, readwrite) NSString *icon;
@property (nonatomic, strong, readwrite) NSString *PoiId;
@property (nonatomic, assign, readwrite) BOOL is_nearby;
@property (nonatomic, strong, readwrite) NSDictionary *location;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *name_en;
@property (nonatomic, strong, readwrite) NSString *opening_time;
@property (nonatomic, strong, readwrite) NSNumber *popularity;
@property (nonatomic, assign, readwrite) BOOL recommended;
@property (nonatomic, strong, readwrite) NSString *recommended_reason;
@property (nonatomic, strong, readwrite) NSString *spot_region;
@property (nonatomic, strong, readwrite) NSString *tel;
@property (nonatomic, strong, readwrite) NSString *time_consuming;
@property (nonatomic, strong, readwrite) NSNumber *time_consuming_max;
@property (nonatomic, strong, readwrite) NSNumber *time_consuming_min;
@property (nonatomic, strong, readwrite) NSString *timezone;
@property (nonatomic, strong, readwrite) NSNumber *type;
@property (nonatomic, assign, readwrite) BOOL verified;
@property (nonatomic, strong, readwrite) NSString *website;






@end
