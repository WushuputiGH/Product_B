//
//  Waypoint.m
//  Product_B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 H. All rights reserved.
//

#import "Waypoint.h"

@implementation Waypoint


- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.photoData forKey:@"photoData"];
    [aCoder encodeObject:self.photo_info forKey:@"photo_info"];
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.local_time  forKey:@"local_time"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.location forKey:@"location"];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.photoData = [aDecoder decodeObjectForKey:@"photoData"];
        self.photo_info = [aDecoder decodeObjectForKey:@"photo_info"];
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.local_time = [aDecoder decodeObjectForKey:@"local_time"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
    }
    return self;
    
    
}

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
