//
//  IntroMainTableModel.m
//  Product_B
//
//  Created by by wushuputi on 16/7/12.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroMainTableModel.h"

@implementation IntroMainTableModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}

+ (NSMutableArray *)tableModelConfigureJsonDic:(NSDictionary *)JsonDic
{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    NSArray *elementsArray = JsonDic[@"data"][@"elements"];
    
    for (NSDictionary *dic1 in elementsArray)
    {
        IntroMainTableModel *model = [[IntroMainTableModel alloc] init];
        
        for (NSString *s in dic1)
        {
            if ([s isEqualToString:@"type"] && [dic1[s] isEqualToNumber: @4])
            {
                NSArray *dataArr = dic1[@"data"];
                
                NSDictionary *dic0 = dataArr[0];
                [model setValuesForKeysWithDictionary:dic0];

                for (NSString *s1 in dic0)
                {

                    if ([s1 isEqualToString:@"user"])
                    {
                        NSDictionary *userDic = dic0[@"user"];
                        model.user = userDic;
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
