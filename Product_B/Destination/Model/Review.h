//
//  Review.h
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Poi.h"

@interface Review : NSObject

@property (nonatomic, strong, readwrite) NSString *content;
@property (nonatomic, strong, readwrite) NSString *datetime;
@property (nonatomic, strong, readwrite) NSString *reviewId;
@property (nonatomic, assign, readwrite) BOOL like;
@property (nonatomic, strong, readwrite) NSNumber *liked_count;
@property (nonatomic, strong, readwrite) Poi *poi;
@property (nonatomic, strong, readwrite) NSNumber *rating;
@property (nonatomic, strong, readwrite) NSString *trip_id;
@property (nonatomic, strong, readwrite) User *theUser;

@end
