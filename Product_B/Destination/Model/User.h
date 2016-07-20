//
//  User.h
//  Product_B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong, readwrite) NSString *avatar_l;
@property (nonatomic, strong, readwrite) NSString *avatar_m;
@property (nonatomic, strong, readwrite) NSString *avatar_s;
@property (nonatomic, strong, readwrite) NSString *birthday;
@property (nonatomic, strong, readwrite) NSString *country_code;
@property (nonatomic, strong, readwrite) NSString *country_num;
@property (nonatomic, strong, readwrite) NSString *cover;
@property (nonatomic, strong, readwrite) NSString *custom_url;
@property (nonatomic, strong, readwrite) NSString *email;
@property (nonatomic, assign, readwrite) BOOL email_verified;
@property (nonatomic, strong, readwrite) NSNumber *gender;
@property (nonatomic, strong, readwrite) NSString *userId;
@property (nonatomic, assign, readwrite) BOOL is_hunter;
@property (nonatomic, strong, readwrite) NSString *location_name;
@property (nonatomic, strong, readwrite) NSString *mobile;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *resident_city_id;
@property (nonatomic, strong, readwrite) NSString *user_desc;
@property (nonatomic, strong, readwrite) NSDictionary *experience;




@end
