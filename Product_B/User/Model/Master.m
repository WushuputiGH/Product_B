//
//  Master.m
//  Product_B
//
//  Created by by wushuputi on 16/7/21.
//  Copyright © 2016年 H. All rights reserved.
//

#import "Master.h"

static Master *defaultMaster = nil;

@implementation Master


+ (Master *)defaultMaster{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultMaster = [[Master alloc] init];
    });
    
    return defaultMaster;
    
}

@end
