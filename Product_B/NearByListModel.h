//
//  NearByListModel.h
//  Product_B
//
//  Created by by wushuputi on 16/7/12.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface NearByItem : NSObject

@property (nonatomic, strong, readwrite) NSString *name; // 名字
@property (nonatomic, strong, readwrite) NSString *cover; // 图片960x720
@property (nonatomic, strong, readwrite) NSString *cover_route_map_cover; // 图片
@property (nonatomic, strong, readwrite) NSString *cover_s;
@property (nonatomic, strong, readwrite) NSNumber *nearByItemId; // id
@property (nonatomic, strong, readwrite) NSNumber *rating; // 评分等级
@property (nonatomic, strong, readwrite) CLLocation *location; // 位置
@property (nonatomic, assign, readwrite) double distance; // 距离
@property (nonatomic, assign, readwrite) NSInteger visited_count; //参观人数
@property (nonatomic, assign, readwrite) NSInteger tips_count; // 点评人数
@property (nonatomic, assign, readwrite) NSInteger wish_to_go_count; // 想去人数
@property (nonatomic, assign, readwrite) NSNumber *type; // 类型
@property (nonatomic, assign, readwrite) BOOL recommended; // 是否推荐
@property (nonatomic, strong, readwrite) NSString *recommended_reason; // 推荐原因

@property (nonatomic, strong, readwrite) NSString *opening_time; // 开放时间
@property (nonatomic, assign, readwrite) NSInteger popularity; // 名气
@property (nonatomic, strong, readwrite) NSString *tel; // 联系方式

@property (nonatomic, strong, readwrite) NSString *url;
@property (nonatomic, strong, readwrite) NSString *name_orig;
@property (nonatomic, assign, readwrite) BOOL has_experience;
@property (nonatomic, strong, readwrite) NSNumber* comments_count;
@property (nonatomic, strong, readwrite) NSNumber *rating_users;
@property (nonatomic, strong, readwrite) NSString *name_zh;
@property (nonatomic, strong, readwrite) NSString *name_en;
@property (nonatomic, strong, readwrite) NSString *slug_url;
@property (nonatomic, assign, readwrite) BOOL has_route_maps;
@property (nonatomic, strong, readwrite) NSString *icon;









@end


@interface NearByListModel : NSObject

@property (nonatomic, strong, readwrite) NSMutableArray *nearByList;

// 用于第一次获取数据
- (void)getFristDataWithJsonDic: (NSDictionary *)jsonDic;

// 用于下拉刷新数据
- (void)getRefreshDataWithJsonDic: (NSDictionary *)jsonDic;

// 用于上拉加载数据
- (void)getMoreDataWithJsonDic: (NSDictionary *)jsonDic;




@end
