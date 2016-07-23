 //
//  IntroTableDetailModel.m
//  Product_B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroTableDetailModel.h"

@implementation IntroTableDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

+ (NSMutableArray *)tableDetailModelConfigureJsonDic:(NSDictionary *)JsonDic
{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *daysArray = JsonDic[@"days"];
    
    for (NSDictionary *dic in daysArray)
    {
        
        NSArray *waypointsArray = dic[@"waypoints"];
        
        for (NSDictionary *dic1 in waypointsArray)
        {
            IntroTableDetailModel *model = [[IntroTableDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic1];
            [modelArray addObject:model];
        }
        
    }
    
    
    return modelArray;
}

@end
