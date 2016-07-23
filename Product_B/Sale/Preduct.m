//
//  Preduct.m
//  0000000
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanoukeji. All rights reserved.
//

#import "Preduct.h"

@implementation Preduct

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}

@end
