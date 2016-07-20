
//
//  DeatinationDetailModel.m
//  Product_B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import "DeatinationDetailModel.h"
#import "Review.h"
#import "Trip.h"
#import "Spot.h"
#import "Waypoint.h"

static DeatinationDetailModel *shareModel = nil;

@implementation DeatinationDetailModel




+ (DeatinationDetailModel *)shareModel{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareModel = [[DeatinationDetailModel alloc] init];
    });
    return shareModel;
}





- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"description"]) {
        self.theDescription = value;
    }
    if ([key isEqualToString:@"impressions"]) {
        NSMutableDictionary *impressionsDic = [NSMutableDictionary dictionary];
        
        NSArray *reviews = value[@"reviews"];
        NSMutableArray *reviewsArray = [NSMutableArray array];
        for (NSDictionary *reviewDic in reviews) {
            Review *review = [[Review alloc] init];
            [review setValuesForKeysWithDictionary:reviewDic];
            [reviewsArray addObject:review];
        }
        [impressionsDic setValue:reviewsArray forKey:@"reviews"];
        
        
        NSMutableArray *tripsArray = [NSMutableArray array];
        NSArray *trips = value[@"trips"];
        
        // 解析数组中
//        NSDictionary *tripDic = trips[0];
//        NSMutableDictionary *newTripDic = [NSMutableDictionary dictionary];
//        Trip *trip = [[Trip alloc] init];
//        [trip setValuesForKeysWithDictionary:tripDic[@"trip"]];
//        [newTripDic setObject:trip forKey:@"trip"];
//        Spot *spot = [[Spot alloc] init];
//        [spot setValuesForKeysWithDictionary:tripDic[@"spot"]];
//        [newTripDic setObject:spot forKey:@"spot"];
//        [tripsArray addObject:newTripDic];
        
    
        for (int i = 0; i < trips.count; i ++) {
            
            NSDictionary *tripDic2 = trips[i];
            NSMutableDictionary *newTripDic2 = [NSMutableDictionary dictionary];
            if ([tripDic2.allKeys containsObject:@"spot"]){
                Trip *trip = [[Trip alloc] init];
                [trip setValuesForKeysWithDictionary:tripDic2[@"trip"]];
                [newTripDic2 setObject:trip forKey:@"trip"];
                Spot *spot = [[Spot alloc] init];
                [spot setValuesForKeysWithDictionary:tripDic2[@"spot"]];
                [newTripDic2 setObject:spot forKey:@"spot"];
            }
            
            if ([tripDic2.allKeys containsObject:@"waypoints"]) {
                [newTripDic2 setValue:tripDic2[@"trip_text"] forKey:@"trip_text"];
                Trip *trip2 = [[Trip alloc] init];
                [trip2 setValuesForKeysWithDictionary:tripDic2[@"trip"]];
                [newTripDic2 setObject:trip2 forKey:@"trip"];
                NSArray *wayPoints = tripDic2[@"waypoints"];
                NSMutableArray *newWaypoints = [NSMutableArray array];
                for (NSDictionary *wayPointDic in wayPoints) {
                    Waypoint *wayPoint = [[Waypoint alloc] init];
                    [wayPoint setValuesForKeysWithDictionary:wayPointDic];
                    [newWaypoints addObject:wayPoint];
                }
                [newTripDic2 setObject:newWaypoints forKey:@"waypoints"];
            }
            [tripsArray addObject:newTripDic2];
        }
      
        [impressionsDic setValue:tripsArray forKey:@"trips"];
        self.theImpressions = impressionsDic;
        
    }
    
    if ([key isEqualToString:@"hottest_places"]) {
        NSMutableArray *hottestPlaces = [NSMutableArray array];
        
        for (NSDictionary *dic in value) {
            HottestPlace *hottestPlace = [[HottestPlace alloc] init];
            [hottestPlace setValuesForKeysWithDictionary:dic];
            [hottestPlaces addObject:hottestPlace];
        }
        self.hottestPlaces = hottestPlaces;
        
    }
    
    
    
}


@end
