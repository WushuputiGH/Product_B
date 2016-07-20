//
//  FocusViewModel.m
//  Product_B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusViewModel.h"
#import "HottestSite.h"

@implementation FocusViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tools = [NSMutableArray array];
        self.hottestSites = [NSMutableArray array];
        self.buttonTitle = [NSMutableArray arrayWithObjects:@"不可错过", @"旅行地点", @"主题榜单", @"精彩原创", @"推荐路线", @"使用须知",@"", @"", nil];
        
        self.buttonIcon = [NSMutableArray arrayWithObjects:@"button0", @"button1",@"button2",@"button3",@"button4",@"button5", @"", @"", nil];
        
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.focusViewId = value;
    }
    if ([key isEqualToString:@"hottest_sites"]) {
        [self.hottestSites removeAllObjects];
        for (NSDictionary *dic in value) {
            HottestSite *hottestSite = [[HottestSite alloc] init];
            [hottestSite setValuesForKeysWithDictionary:dic];
            [self.hottestSites addObject:hottestSite];
        }

    }
}


- (void)setTools:(NSMutableArray *)tools{
    
    _tools = [tools mutableCopy];
    
    // 后台给的数据, 有的是七个, 有的是8个, 七个的时候, 加一条假数据, 砍死后台!!!!!!!!
    if (_tools.count == 7) {
        [_tools insertObject:@{@"url": @""} atIndex:0];
    }
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (int i = 0; i < _tools.count; i ++) {
        if (i != 1 && i != 3) {
            if (!_tools[i][@"url"] || [_tools[i][@"url"]  isEqual: @""]) {
                [indexSet addIndex:i];
            }
        }
    }
    [self.buttonIcon removeObjectsAtIndexes:indexSet];
    [self.buttonTitle removeObjectsAtIndexes:indexSet];
    [_tools removeObjectsAtIndexes:indexSet];
    
    
    
}


@end
