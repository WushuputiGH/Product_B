//
//  Waypoint.m
//  Product_B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 H. All rights reserved.
//

#import "Waypoint.h"

@implementation Waypoint


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.waypointId = value;
    }
}


- (void)setDate_added:(NSString *)date_added{
    
    double dateDouble = [date_added doubleValue];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateDouble];
    _date_added = date.description;
}

@end
