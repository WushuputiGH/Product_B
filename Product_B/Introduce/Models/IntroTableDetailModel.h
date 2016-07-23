//
//  IntroTableDetailModel.h
//  Product_B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroTableDetailModel : NSObject

@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *local_time;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDictionary *poi;
@property (nonatomic, assign) NSInteger trip_id;
@property (nonatomic, strong) NSString *trackpoints_thumbnail_image;
@property (nonatomic, strong) NSNumber *photo_height;
@property (nonatomic, strong) NSNumber *photo_width;




+ (NSMutableArray *)tableDetailModelConfigureJsonDic:(NSDictionary *)JsonDic;


@end
