//
//  NearByListModel.m
//  Product_B
//
//  Created by by wushuputi on 16/7/12.
//  Copyright © 2016年 H. All rights reserved.
//

#import "NearByListModel.h"

@implementation NearByItem

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.nearByItemId = value;
    }
    if ([key isEqualToString:@"location"]) {
        value = (NSDictionary *)value;
        
        NSNumber *latitudeNum = value[@"lat"];
        NSNumber *longitudeNum = value[@"lng"];
        
        self.location = [[CLLocation alloc] initWithLatitude:latitudeNum.doubleValue longitude:longitudeNum.doubleValue];        
    }
    
    
}

@end





@implementation NearByListModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nearByList = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)getFristDataWithJsonDic: (NSDictionary *)jsonDic{
    
    self.nearByList = [self analysisJson:jsonDic];
    
}

// 用于下拉刷新数据
- (void)getRefreshDataWithJsonDic: (NSDictionary *)jsonDic{
    NSMutableArray *array = [self analysisJson:jsonDic];
    
    // 获取目前已经存在的id
    NSArray *nearByIds = [self.nearByList valueForKeyPath:@"nearByItemId"];
    
    // 判断新获取是数据是否已经存在, 如果不存在, 插入最前面
    for (NSInteger i = array.count - 1; i >= 0; i --) {
        NearByItem *item = array[i];
        if (![nearByIds containsObject: item.nearByItemId]) {
            [self.nearByList insertObject:item atIndex:0];
        }
    }
}

// 用于上拉加载数据
- (void)getMoreDataWithJsonDic: (NSDictionary *)jsonDic{
    NSMutableArray *array = [self analysisJson:jsonDic];
    [self.nearByList addObjectsFromArray:array];
}



// 进行json解析
/**
 *  传入的是网路请求下来的字典
 *  返回值是一个可变数组, 数组中的元素类型时NearByItem
 */

- (NSMutableArray *)analysisJson:(NSDictionary *)jsonDic{
    
    NSMutableArray *array = [NSMutableArray array];
    NSArray *items = jsonDic[@"items"];
    for (NSDictionary *item in items) {
        NearByItem *nearByItem = [[NearByItem alloc] init];
        [nearByItem setValuesForKeysWithDictionary:item];
        [array addObject:nearByItem];
    }
    return array;
}




@end
