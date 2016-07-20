//
//  OriginalDetailModel.m
//  Product_B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalDetailModel.h"


@implementation Day


- (void)setWaypoints:(NSMutableArray<Waypoint *> *)waypoints{
    
    _waypoints = [[NSMutableArray array] init];
    for (NSDictionary *dic in waypoints) {
        Waypoint *waypoiont = [[Waypoint alloc] init];
        [waypoiont setValuesForKeysWithDictionary:dic];
        [_waypoints addObject:waypoiont];
    }
}


@end



@implementation OriginalDetailModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.theId = value;
    }
    
    if ([key isEqualToString:@"poi_infos_count"]) {
        self.flight = value[@"flight"];
        self.mall = value[@"mall"];
        self.hotel = value[@"hotel"];
        self.sights = value[@"sights"];
        self.restaurant = value[@"restaurant"];
    }
    if ([key isEqualToString:@"user"]) {
        self.theUser = [[User alloc] init];
        [self.theUser setValuesForKeysWithDictionary:value];
    }
    
}



- (void)setDays:(NSArray *)days{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in days) {
        Day *day = [[Day alloc] init];
        [day setValuesForKeysWithDictionary:dic];
        [array addObject:day];
    }
    _days = array;
}

@end
