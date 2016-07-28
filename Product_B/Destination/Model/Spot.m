//
//  Spot.m
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import "Spot.h"

@implementation SpotDetail

@end



@implementation Spot


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.theDetail_list = [NSMutableArray array];
    }
    return self;
}





- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
  
    if ([key isEqualToString:@"detail_list"]) {
        [self.theDetail_list removeAllObjects];
        NSArray *valueList = value;
        for (NSDictionary *detail in valueList) {
            SpotDetail *spotDetail = [[SpotDetail alloc] init];
            [spotDetail setValuesForKeysWithDictionary:detail];
            [self.theDetail_list addObject:spotDetail];
        }
    }
}


@end
