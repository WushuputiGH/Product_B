//
//  Review.m
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import "Review.h"
#import "User.h"
@implementation Review


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.reviewId = value;
    }
    if ([key isEqualToString:@"user"]) {
        self.theUser = [[User alloc] init];
        [self.theUser setValuesForKeysWithDictionary:value];
    }
}





@end
