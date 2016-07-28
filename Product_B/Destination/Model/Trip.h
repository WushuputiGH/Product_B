//
//  Trip.h
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface Trip : NSObject
@property (nonatomic, strong, readwrite) NSString *cover_image;
@property (nonatomic, strong, readwrite) NSString *cover_image_1600;
@property (nonatomic, strong, readwrite) NSString *cover_image_w640;
@property (nonatomic, strong, readwrite) NSString *date_added;
@property (nonatomic, strong, readwrite) NSNumber *day_count;
@property (nonatomic, assign, readwrite) BOOL isDefault;
@property (nonatomic, strong, readwrite) NSString *tripId;
@property (nonatomic, assign, readwrite) BOOL is_author;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *privacy;
@property (nonatomic, strong, readwrite) NSString *share_url;
@property (nonatomic, strong, readwrite) NSString *start_point;
@property (nonatomic, strong, readwrite) NSString *timezone;
@property (nonatomic, strong, readwrite) NSString *version;
@property (nonatomic, strong, readwrite) NSString *wifi_sync;
@property (nonatomic, strong, readwrite) User *theUser;



@end
