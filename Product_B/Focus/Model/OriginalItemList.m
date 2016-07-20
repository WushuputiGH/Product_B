//
//  OriginalItemList.m
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalItemList.h"


@implementation OriginalItemList

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"data"]) {
        self.next_start = value[@"next_start"];
        NSArray *items = value[@"items"];
        self.originalItemList = [self originalItemListFrom:items];
    }
}


- (void)getMoreDataWithJsonDic:(NSDictionary *)jsonDic{
    self.staus = jsonDic[@"status"];
    self.message = jsonDic[@"message"];
    NSArray *items = [jsonDic valueForKeyPath:@"data.items"];
    self.next_start = [jsonDic valueForKeyPath:@"data.next_start"];
    [self.originalItemList addObjectsFromArray:[self originalItemListFrom:items]];
}


- (NSMutableArray *)originalItemListFrom:(NSArray *)items{
    
    NSMutableArray *newItems = [NSMutableArray array];
    for (NSDictionary *dic in items) {
        OriginalItem *originaItem = [[OriginalItem alloc] init];
        [originaItem setValuesForKeysWithDictionary:dic];
        [newItems addObject:originaItem];
    }
    return  newItems;

}


@end
