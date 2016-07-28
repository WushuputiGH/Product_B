//
//  Poi.m
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import "Poi.h"

@implementation Poi


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
   
    if ([key isEqualToString:@"description"]) {
        self.Poidescription = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.PoiId = value;
    }
}


@end
