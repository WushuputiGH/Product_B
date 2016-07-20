//
//  Spot.h
//  Product_B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpotDetail : NSObject
@property (nonatomic, strong, readwrite) NSString *detail_id;
@property (nonatomic, strong, readwrite) NSDictionary *location;
@property (nonatomic, strong, readwrite) NSString *photo;
@property (nonatomic, strong, readwrite) NSString *photo_1600;
@property (nonatomic, strong, readwrite) NSString *photo_date_created;
@property (nonatomic, strong, readwrite) NSNumber *photo_height;
@property (nonatomic, strong, readwrite) NSString *photo_s;
@property (nonatomic, strong, readwrite) NSString *photo_w640;
@property (nonatomic, strong, readwrite) NSNumber *photo_width;
@property (nonatomic, strong, readwrite) NSString *text;
@property (nonatomic, strong, readwrite) NSString *timezone;
@property (nonatomic, strong, readwrite) NSString *type;

@end



@interface Spot : NSObject

@property (nonatomic, strong, readwrite) NSDictionary *center_point;
@property (nonatomic, strong, readwrite) NSString *comments_count;
@property (nonatomic, strong, readwrite) NSString *date_toure;
@property (nonatomic, strong, readwrite) NSMutableArray *theDetail_list;
@property (nonatomic, assign, readwrite) BOOL is_author;
@property (nonatomic, assign, readwrite) BOOL is_hiding_location;
@property (nonatomic, strong, readwrite) NSString *location_alias;
@property (nonatomic, strong, readwrite) NSNumber *recommendations_count;
@property (nonatomic, strong, readwrite) NSDictionary *region;
@property (nonatomic, strong, readwrite) NSString *share_url;
@property (nonatomic, strong, readwrite) NSString *spot_id;
@property (nonatomic, strong, readwrite) NSString *text;
@property (nonatomic, strong, readwrite) NSString *timezone;
@property (nonatomic, strong, readwrite) NSString *trip_id;
@property (nonatomic, strong, readwrite) NSNumber *view_count;

@end
