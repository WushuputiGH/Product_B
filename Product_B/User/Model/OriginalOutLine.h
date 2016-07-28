//
//  OriginalOutLine.h
//  Product_B
//
//  Created by by wushuputi on 16/7/21.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OriginalItem.h"
#import "OriginalDetailModel.h"

@interface OriginalOutLine : NSObject<NSCoding>

@property (nonatomic, strong, readwrite) OriginalDetailModel *originalDetailModel;
@property (nonatomic, strong, readwrite) OriginalItem *originalItem;



- (void)archiver;


@end
