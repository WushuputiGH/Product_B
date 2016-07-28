//
//  OriginalOutLineId.h
//  Product_B
//
//  Created by by wushuputi on 16/7/21.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用来储存已经下载好的OriginalOutLine对应的key值
 */
@interface OriginalOutLineId : NSObject

@property (nonatomic, strong, readwrite) NSMutableArray *originalOutlineIdArray;
@property (nonatomic, strong, readwrite) NSMutableArray *downImageArray; // 每一个元素都是一个字典, key是指id, value是图片

+ (OriginalOutLineId *)defaultOriginalOutlineIdArray;


- (void)synchronize;
- (void)addDownloadOriginalOutLine: (NSDictionary *)dic;

@end
