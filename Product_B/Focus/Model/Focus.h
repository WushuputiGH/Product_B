//
//  Focus.h
//  Product_B
//
//  Created by by wushuputi on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearByListModel.h"


/**
 *  聚焦板块中的一个element
 */
@interface Focus : NSObject

@property (nonatomic, strong, readwrite) NSNumber *index;
@property (nonatomic, assign, readwrite) BOOL more;
@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) NSMutableArray<NearByItem *> *dataList; // 里面存储NearByItem类型数组


@end
