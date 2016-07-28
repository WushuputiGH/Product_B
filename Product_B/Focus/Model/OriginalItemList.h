//
//  OriginalItemList.h
//  Product_B
//
//  Created by by wushuputi on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OriginalItem.h"

@interface OriginalItemList : NSObject

@property (nonatomic, strong, readwrite) NSNumber *staus;
@property (nonatomic, strong, readwrite) NSString *message;
@property (nonatomic, strong, readwrite) NSMutableArray *originalItemList;
@property (nonatomic, strong, readwrite) NSNumber *next_start;



- (void)getMoreDataWithJsonDic:(NSDictionary *)jsonDic;

@end
