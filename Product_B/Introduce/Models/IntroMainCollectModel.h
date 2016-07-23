//
//  IntroMainCollectModel.h
//  Product_B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroMainCollectModel : NSObject

@property (nonatomic, strong) NSString *avatar_l; // 头像
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *index_cover;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSDictionary *user;
@property (nonatomic, strong) NSDictionary *poi;


@property (nonatomic, strong) NSString *trip_id; 
@property (nonatomic, strong) NSString *spot_id;
@property (nonatomic, strong) NSString *text;




+ (NSMutableArray *)collectConfigureJsonDic:(NSDictionary *)JsonDIc;


@end
