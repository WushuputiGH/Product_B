//
//  FocusListModel.m
//  Product_B
//
//  Created by by wushuputi on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusListModel.h"

@implementation FocusListModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.theBanners = [NSMutableArray array];
        self.theElements = [NSMutableArray array];
    }
    return self;
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"banners"]) {
        [self.theBanners removeAllObjects];
        for (NSDictionary *dic in value) {
            Banners *banners = [[Banners alloc] init];
            [banners setValuesForKeysWithDictionary:dic];
            [self.theBanners addObject:banners];
        }
    }
    if ([key isEqualToString:@"elements"]) {
        [self.theElements removeAllObjects];
        for (NSDictionary *dic in value) {
            Focus *focus = [[Focus alloc] init];
            [focus setValuesForKeysWithDictionary:dic];
            [self.theElements addObject:focus];
        }
    }
}


@end
