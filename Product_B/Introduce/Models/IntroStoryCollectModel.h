//
//  IntroStoryCollectModel.h
//  Product_B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroStoryCollectModel : NSObject

@property (nonatomic, strong) NSString *index_cover;
@property (nonatomic, strong) NSDictionary *poi;
@property (nonatomic, strong) NSDictionary *user;
@property (nonatomic, strong) NSString *spot_id;
@property (nonatomic, strong) NSString *trip_id;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *date_tour;







+ (NSMutableArray *)storyCollectModelConfigureJsonDic:(NSDictionary *)JsonDic;


@end
