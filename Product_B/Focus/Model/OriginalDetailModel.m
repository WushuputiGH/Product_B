//
//  OriginalDetailModel.m
//  Product_B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalDetailModel.h"

/*
 self.title.text = model.name;
 self.name.text = model.theUser.name;
 
 [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.theUser.avatar_m] forState:(UIControlStateNormal)];
 self.iconButton.layer.cornerRadius = 25;
 self.iconButton.clipsToBounds = YES;
 
 self.time.text = model.first_day.description;
 self.daysCount.text = model.day_count.description;
 self.miles.text = model.mileage.description;
 self.liker.text = model.recommendations.description;
 
 [self.theImageView sd_setImageWithURL:[NSURL URLWithString:model.trackpoints_thumbnail_image]];
 self.theImageView.contentMode = UIViewContentModeScaleAspectFill;
 self.theImageView.clipsToBounds = YES;
 */


@implementation Day

- (void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.day forKey:@"day"];
    [aCoder encodeObject:self.waypoints forKey:@"waypoints"];
    
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.day = [aDecoder decodeObjectForKey:@"day"];
        self.waypoints = [aDecoder decodeObjectForKey:@"waypoints"];
    }
    return self;
}


- (void)setWaypoints:(NSMutableArray<Waypoint *> *)waypoints{
    
    _waypoints = [[NSMutableArray array] init];
    
    if ([waypoints[0] isKindOfClass:[NSDictionary class]]) {
        for (NSDictionary *dic in waypoints) {
            Waypoint *waypoiont = [[Waypoint alloc] init];
            [waypoiont setValuesForKeysWithDictionary:dic];
            [_waypoints addObject:waypoiont];
        }
    }else{
        _waypoints = waypoints;
    }
   
}


@end



@implementation OriginalDetailModel


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.theId forKey:@"theId"];
    [aCoder encodeObject:self.trackpoints_thumbnail_image_Data forKey:@"trackpoints_thumbnail_image_Data"];
    [aCoder encodeObject:self.cover_image_Data forKey:@"cover_image_Data"];
    [aCoder encodeObject:self.first_day forKey:@"first_day"];
    [aCoder encodeObject:self.day_count forKey:@"day_count"];
    [aCoder encodeObject:self.mileage forKey:@"mileage"];
    [aCoder encodeObject:self.recommendations forKey:@"recommendations"];
    [aCoder encodeObject:self.flight forKey:@"flight"];
    [aCoder encodeObject:self.mall forKey:@"mall"];
    [aCoder encodeObject:self.sights forKey:@"sights"];
    [aCoder encodeObject:self.restaurant forKey:@"restaurant"];
    [aCoder encodeObject:self.hotel forKey:@"hotel"];
    [aCoder encodeObject:self.covered_countries forKey:@"covered_countries"];
    [aCoder encodeObject:self.theUser forKey:@"theUser"];
    [aCoder encodeObject:self.days forKey:@"days"];
    [aCoder encodeObject:self.trackpoints forKey:@"trackpoints"];
    
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.theId = [aDecoder decodeObjectForKey:@"theId"];
        self.trackpoints_thumbnail_image_Data = [aDecoder decodeObjectForKey:@"trackpoints_thumbnail_image_Data"];
        self.cover_image_Data = [aDecoder decodeObjectForKey:@"cover_image_Data"];
        self.first_day = [aDecoder decodeObjectForKey:@"first_day"];
        self.day_count = [aDecoder decodeObjectForKey:@"day_count"];
        self.mileage = [aDecoder decodeObjectForKey:@"mileage"];
        self.recommendations = [aDecoder decodeObjectForKey:@"recommendations"];
        self.flight = [aDecoder decodeObjectForKey:@"flight"];
        self.mall = [aDecoder decodeObjectForKey:@"mall"];
        self.sights = [aDecoder decodeObjectForKey:@"sights"];
        self.restaurant = [aDecoder decodeObjectForKey:@"restaurant"];
        self.hotel = [aDecoder decodeObjectForKey:@"hotel"];
        self.covered_countries = [aDecoder decodeObjectForKey:@"covered_countries"];
        self.theUser = [aDecoder decodeObjectForKey:@"theUser"];
        self.days = [aDecoder decodeObjectForKey:@"days"];
        self.trackpoints = [aDecoder decodeObjectForKey:@"trackpoints"];
    }
    return self;
}


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
    
    if ([days[0] isKindOfClass:[NSDictionary class]]) {
        for (NSDictionary *dic in days) {
            Day *day = [[Day alloc] init];
            [day setValuesForKeysWithDictionary:dic];
            [array addObject:day];
        }
        _days = array;
    }else{
        _days = days;
    }
    
    
}

@end
