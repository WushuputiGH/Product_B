//
//  IntroStoryCollectModel.m
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroStoryCollectModel.h"

@implementation IntroStoryCollectModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

+ (NSMutableArray *)storyCollectModelConfigureJsonDic:(NSDictionary *)JsonDic
{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    NSArray *hot_spot_listArray = JsonDic[@"data"][@"hot_spot_list"];
    
    for (NSDictionary *dic in hot_spot_listArray)
    {
        IntroStoryCollectModel *model = [[IntroStoryCollectModel alloc] init];
        
        [model setValuesForKeysWithDictionary:dic];
    
        [modelArray addObject:model];
    }
    
    
    return modelArray;
}



@end
