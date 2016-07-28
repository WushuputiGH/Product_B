//
//  FocusViewModel.h
//  Product_B
//
//  Created by by wushuputi on 16/7/17.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HottestSite.h"



@interface FocusViewModel : NSObject

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *name_zh;
@property (nonatomic, strong, readwrite) NSMutableArray *tools; // 里面包括键值url, type的两对数据
@property (nonatomic, strong, readwrite) NSNumber *visited_count; // 参观人数
@property (nonatomic, strong, readwrite) NSNumber *wish_to_go_count; // 想去人数
@property (nonatomic, strong, readwrite) NSString *focusViewId; // id
@property (nonatomic, strong, readwrite) NSNumber *type; // 类型
@property (nonatomic, strong, readwrite) NSMutableArray *hottest_places; // 
@property (nonatomic, strong, readwrite) NSMutableArray *hottestSites;


// 用于存储button的标题和图标
@property (nonatomic, strong)NSMutableArray *buttonTitle;
@property (nonatomic, strong)NSMutableArray *buttonIcon;


@end
