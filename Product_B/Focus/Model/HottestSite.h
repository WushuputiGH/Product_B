//
//  HottestSite.h
//  Product_B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HottestSite : NSObject

@property (nonatomic, strong, readwrite) NSNumber *rating;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *cover;
@property (nonatomic, strong, readwrite) NSString *cover_s;
@property (nonatomic, strong, readwrite) NSString *cover_route_map_cover;
@property (nonatomic, strong, readwrite) NSNumber *type;
@property (nonatomic, strong, readwrite) NSNumber *hottestSiteId;
@property (nonatomic, strong, readwrite) NSNumber *tips_count;



@end
