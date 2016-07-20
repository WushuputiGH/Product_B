//
//  HottestSite.m
//  Product_B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 H. All rights reserved.
//

#import "HottestSite.h"

@implementation HottestSite


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.hottestSiteId = value;
    }
}



@end
