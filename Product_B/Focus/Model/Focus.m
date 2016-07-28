//
//  Focus.m
//  Product_B
//
//  Created by by wushuputi on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import "Focus.h"


@implementation Focus


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"data"]) {
        self.dataList = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            NearByItem *nearByItem = [[NearByItem alloc] init];
            [nearByItem setValuesForKeysWithDictionary:dic];
            [self.dataList addObject:nearByItem];
        }
    }
}





@end
