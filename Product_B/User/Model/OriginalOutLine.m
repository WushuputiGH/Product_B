//
//  OriginalOutLine.m
//  Product_B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalOutLine.h"
#import "OriginalOutLineId.h"

@implementation OriginalOutLine


- (void)encodeWithCoder:(NSCoder *)aCoder{
   
    [aCoder encodeObject:self.originalItem forKey:@"originalItem"];
    [aCoder encodeObject:self.originalDetailModel forKey:@"originalDetailModel"];
 
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.originalItem = [aDecoder decodeObjectForKey:@"originalItem"];
        self.originalDetailModel = [aDecoder decodeObjectForKey:@"originalDetailModel"];
    }
    return self;
}


- (void)archiver{
    // 在归档之前, 首先要下载所有的图片
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
      // 下载item中的图片
    dispatch_group_async(group, queue, ^{
        
         self.originalItem.cover_image_default_Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.originalItem.cover_image_default]];
    
    });
    
     // 下载originalDetailModel中的图片
    dispatch_group_async(group, queue, ^{
        self.originalDetailModel.trackpoints_thumbnail_image_Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.originalDetailModel.trackpoints_thumbnail_image]];
        self.originalDetailModel.cover_image_Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.originalDetailModel.cover_image]];
    
    });
    
    //  下载originalDetailModel中user的图片
    dispatch_group_async(group, queue, ^{
        User *user = self.originalDetailModel.theUser;
        user.avatar_l_Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.avatar_l]];
        user.avatar_m_Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.avatar_m]];
        user.avatar_s_Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.avatar_s]];
        user.coverData = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.cover]];
    
    });
    
      // 下载originalDetailModel中days的waypoint中所有的图片
    dispatch_group_async(group, queue, ^{
        for (Day *day in self.originalDetailModel.days) {
            for (Waypoint *wayPoint in day.waypoints) {
                wayPoint.photoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:wayPoint.photo]];
            }
        }
        
    });
    
#pragma mark ---当图片下载完后之后, 归档数据---
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
        NSString *key = [NSString stringWithFormat:@"OriginalOutline%@", self.originalItem.originalItemId];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey: key];
        NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(9, 1, 1) firstObject]);
        
        // 归档完成之后, 将key值存起来, 同步
        [[OriginalOutLineId defaultOriginalOutlineIdArray].originalOutlineIdArray addObject:key];
        [[OriginalOutLineId defaultOriginalOutlineIdArray] synchronize];

    });

    
}


@end
