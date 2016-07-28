//
//  OriginalItem.m
//  Product_B
//
//  Created by by wushuputi on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalItem.h"

@implementation OriginalItem

/*
self.name.text = originalItem.name;

// 首先将时间戳转化成时间
NSDate *date = [NSDate dateWithTimeIntervalSince1970:originalItem.date_added.doubleValue];
NSString *dateString = [[date.description componentsSeparatedByString:@" "] firstObject];
self.timeAndWaypoints.text  = [NSString stringWithFormat:@"%@  %@足迹", dateString, originalItem.waypoints];
self.viewCount.text = [NSString stringWithFormat:@"%@浏览", originalItem.view_count];
self.recommendations.text = [NSString stringWithFormat:@"%@喜欢", originalItem.recommendations];
self.total_comments_count.text = [NSString stringWithFormat:@"%@评论", originalItem.total_comments_count];

[self.theImageview sd_setImageWithURL:[NSURL URLWithString:originalItem.cover_image_default]];
*/

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.date_added forKey:@"data_added"];
    [aCoder encodeObject:self.waypoints forKey:@"waypoints"];
    [aCoder encodeObject:self.view_count forKey:@"view_count"];
    [aCoder encodeObject:self.recommendations forKey:@"recommmendations"];
    [aCoder encodeObject:self.total_comments_count forKey:@"total_comments_count"];
    [aCoder encodeObject:self.cover_image_default_Data forKey:@"cover_image_default_Data"];

}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.date_added = [aDecoder decodeObjectForKey:@"data_added"];
        self.waypoints = [aDecoder decodeObjectForKey:@"waypoints"];
        self.view_count = [aDecoder decodeObjectForKey:@"view_count"];
        self.recommendations = [aDecoder decodeObjectForKey:@"recommmendations"];
        self.total_comments_count = [aDecoder decodeObjectForKey:@"total_comments_count"];
        self.cover_image_default_Data = [aDecoder decodeObjectForKey:@"cover_image_default_Data"];        
    }
    return self;
    
}




- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.originalItemId = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.originalItemDescription = value;
    }
    if ([key isEqualToString:@"default"]) {
        self.originalItemDefault = value;
    }
}

@end
