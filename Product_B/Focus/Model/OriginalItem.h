//
//  OriginalItem.h
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OriginalItem : NSObject <NSCoding>
@property (nonatomic, strong, readwrite) NSNumber *waypoints;
@property (nonatomic, assign, readwrite) BOOL wifi_sync;
@property (nonatomic, strong, readwrite) NSNumber *total_comments_count;
@property (nonatomic, strong, readwrite) NSNumber *originalItemId;

@property (nonatomic, strong, readwrite) NSNumber *view_count;
@property (nonatomic, strong, readwrite) NSNumber *privacy;
@property (nonatomic, strong, readwrite) NSNumber *day_count;

@property (nonatomic, strong, readwrite) NSNumber *version;
@property (nonatomic, strong, readwrite) NSNumber *spot_count;
@property (nonatomic, strong, readwrite) NSNumber *mileage;

@property (nonatomic, strong, readwrite) NSString *originalItemDescription;;
@property (nonatomic, strong, readwrite) NSNumber *last_modified;
@property (nonatomic, strong, readwrite) NSString *cover_image_default;
@property (nonatomic, strong, readwrite) NSData *cover_image_default_Data;

@property (nonatomic, strong, readwrite) NSNumber *date_complete;
@property (nonatomic, strong, readwrite) NSNumber *device;
@property (nonatomic, strong, readwrite) NSNumber *date_added;

@property (nonatomic, strong, readwrite) NSString *cover_image_w640;
@property (nonatomic, strong, readwrite) NSData *cover_image_w640_Data;

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) BOOL originalItemDefault;
@property (nonatomic, strong, readwrite) NSNumber *recommendations;
@property (nonatomic, strong, readwrite) NSString *cover_image_1600;
@property (nonatomic, strong, readwrite) NSData *cover_image_1600_Data;

@property (nonatomic, strong, readwrite) NSString *cover_image;
@property (nonatomic, strong, readwrite) NSData *cover_image_Data;


@end
