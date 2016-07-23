//
//  IntroMainCollectModel.m
//  Product_B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroMainCollectModel.h"

@implementation IntroMainCollectModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}


+(NSMutableArray *)collectConfigureJsonDic:(NSDictionary *)JsonDIc
{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *elementsArray = JsonDIc[@"data"][@"elements"];
    for (NSDictionary *dic1 in elementsArray)
    {
        IntroMainCollectModel *model = [[IntroMainCollectModel alloc] init];

        for (NSString *s in dic1)
        {
            if ([s isEqualToString:@"type"] && [dic1[s] isEqualToNumber: @10])
            {
                NSArray *dataArr = dic1[@"data"];
                
                NSDictionary *dic0 = dataArr[0];
                for (NSString *s1 in dic0)
                {
                    if ([s1 isEqualToString:@"spot_id"])
                    {
                        model.spot_id = dic0[@"spot_id"];
                    }
                    
                    if ([s1 isEqualToString:@"text"])
                    {
                        model.text = dic0[@"text"];
                    }
                    
                    if ([s1 isEqualToString:@"index_cover"])
                    {
                        model.index_cover = dic0[s1];
                    }
                    
                    if ([s1 isEqualToString:@"user"])
                    {
                        NSDictionary *userDic = dic0[@"user"];
                        for (NSString *s2 in userDic)
                        {
                            if ([s2 isEqualToString:@"avatar_l"])
                            {
                                model.avatar_l = userDic[s2];
                            }
                            else if ([s2 isEqualToString:@"name"])
                            {
                                model.name = userDic[s2];
                            }
                        }
                    }
                }
                [model setValuesForKeysWithDictionary:dic1];
                
                [modelArray addObject:model];
            }
        }
    }
    
    
    return modelArray;
}

@end
