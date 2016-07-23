//
//  IntroCollectDetailModel.m
//  Product_B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroCollectDetailModel.h"

@implementation IntroCollectDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}


+ (NSMutableArray *)collectDetailModelConfigureJsonDic:(NSDictionary *)JsonDic
{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSDictionary *dataDic = JsonDic[@"data"];
    NSDictionary *spotDic = dataDic[@"spot"];
    NSArray *detail_listArray = spotDic[@"detail_list"];
    
    for (NSDictionary *dic in detail_listArray)
    {
        IntroCollectDetailModel *model = [[IntroCollectDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}



@end
