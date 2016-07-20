//
//  OriginalItem.m
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalItem.h"

@implementation OriginalItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.originalItemId = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.originalItemDescription = value;
    }
    if ([key isEqualToString:@"default"]) {
        self.originalItemDefault = value;
    }
}

@end
