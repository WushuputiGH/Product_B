//
//  IntroMainTableModel.h
//  Product_B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroMainTableModel : NSObject

@property (nonatomic, strong) NSString *cover_image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *first_day;
@property (nonatomic, assign) NSInteger day_count;
@property (nonatomic, assign) NSInteger view_count;
@property (nonatomic, strong) NSString *popular_place_str;
@property (nonatomic, strong) NSString *avatar_l;
@property (nonatomic, strong) NSDictionary *user;
@property (nonatomic, assign) NSInteger id;

+ (NSMutableArray *)tableModelConfigureJsonDic:(NSDictionary *)JsonDic;








@end
