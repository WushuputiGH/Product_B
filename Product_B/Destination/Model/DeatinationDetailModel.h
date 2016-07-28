//
//  DeatinationDetailModel.h
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import "NearByListModel.h"
#import "HottestPlace.h"





@interface DeatinationDetailModel : NearByItem

/**
 *  印象中包含: 部分印象以及部分评论
 */
@property (nonatomic, strong, readwrite) NSDictionary *theImpressions; // 印象
@property (nonatomic, strong, readwrite) NSString *theDescription; // 描述
@property (nonatomic, strong, readwrite) NSString *address; // 地址
@property (nonatomic, strong, readwrite) NSString *arrival_type; // 到达方式
@property (nonatomic, strong, readwrite) NSString *fee; // 门票

@property (nonatomic, strong, readwrite) NSMutableArray *hottestPlaces;






// 创建一个单例
+ (DeatinationDetailModel *)shareModel;


@end
