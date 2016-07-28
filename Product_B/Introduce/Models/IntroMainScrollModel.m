//
//  IntroMainScrollModel.m
//  Product_B
//
//  Created by by wushuputi on 16/7/12.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroMainScrollModel.h"

@implementation IntroMainScrollModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}


+ (NSMutableArray *)IntroScrollModelConfigureJsonDic:(NSDictionary *)JsonDic
{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    NSArray *BannersArr = JsonDic[@"Response"][@"Banners"];
    for (NSDictionary *dic in BannersArr)
    {
        IntroMainScrollModel *model = [[IntroMainScrollModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        
        [modelArray addObject:model];
        
    }
    
    return modelArray;
}

@end
