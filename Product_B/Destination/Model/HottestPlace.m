//
//  HottestPlace.m
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import "HottestPlace.h"

@implementation HottestPlace

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.hottestPlaceId = value;
    }
}

@end
