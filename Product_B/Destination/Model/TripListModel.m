//
//  TripListModel.m
//  Product_B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 H. All rights reserved.
//

#import "TripListModel.h"

static TripListModel *shareTripListModel = nil;

@implementation TripListModel


+ (TripListModel *)shareTripListModel{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareTripListModel = [[TripListModel alloc] init];
    });
    return shareTripListModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        {
            self.next_start = @0;
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"data"]) {
        self.next_start = value[@"next_start"];
        self.trips = [NSMutableArray array];
        NSArray *trips = value[@"trips"];
        for (int i = 0; i < trips.count; i ++) {
            NSDictionary *tripDic = trips[i];
            NSMutableDictionary *newTripDic = [NSMutableDictionary dictionary];
            Trip *trip = [[Trip alloc] init];
            [trip setValuesForKeysWithDictionary:tripDic[@"trip"]];
            [newTripDic setValue:trip forKey:@"trip"];
            
            if ([tripDic.allKeys containsObject:@"spot"]) {
                Spot *spot = [[Spot alloc] init];
                [spot setValuesForKeysWithDictionary:tripDic[@"spot"]];
                [newTripDic setValue:spot forKey:@"spot"];
            }
            
            if ([tripDic.allKeys containsObject:@"waypoints"]) {
                [newTripDic setValue:tripDic[@"trip_text"] forKey:@"trip_text"];
                
                NSArray *wayPoints = tripDic[@"waypoints"];
                NSMutableArray *newWaypoints = [NSMutableArray array];
                for (NSDictionary *wayPointDic in wayPoints) {
                    Waypoint *wayPoint = [[Waypoint alloc] init];
                    [wayPoint setValuesForKeysWithDictionary:wayPointDic];
                    [newWaypoints addObject:wayPoint];
                }
                [newTripDic setObject:newWaypoints forKey:@"waypoints"];
            }
           
            [self.trips addObject:newTripDic];
        }
    }
}


- (void)requstMoreData:(NSDictionary *)jsonDic{
    TripListModel *newModel = [[TripListModel alloc] init];
    [newModel setValuesForKeysWithDictionary:jsonDic];
    self.next_start = newModel.next_start;
    self.message = newModel.message;
    self.statue = newModel.statue;
    [self.trips addObjectsFromArray:newModel.trips];
}

@end
