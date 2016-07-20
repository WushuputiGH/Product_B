//
//  Trip.m
//  Product_B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import "Trip.h"
#import "User.h"

@implementation Trip

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.theUser = [[User alloc] init];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"default"]) {
        self.isDefault =value;
    }
    if ([key isEqualToString:@"id"]) {
        self.tripId = value;
    }
    if ([key isEqualToString:@"user"]) {
        [self.theUser setValuesForKeysWithDictionary:value];
    }
}

@end
