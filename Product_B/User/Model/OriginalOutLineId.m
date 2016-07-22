//
//  OriginalOutLineId.m
//  Product_B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalOutLineId.h"

@implementation OriginalOutLineId


+ (OriginalOutLineId *)defaultOriginalOutlineIdArray{
    static OriginalOutLineId *originalOutlineIds = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        originalOutlineIds = [[OriginalOutLineId alloc] init];
        originalOutlineIds.originalOutlineIdArray = [[[NSUserDefaults standardUserDefaults] valueForKey:@"originalOutlineIdArray"] mutableCopy];
        if (originalOutlineIds.originalOutlineIdArray == nil) {
            originalOutlineIds.originalOutlineIdArray = [NSMutableArray array];
        }
        originalOutlineIds.downImageArray = [NSMutableArray array];
    });
    return originalOutlineIds;
    
}

- (void)synchronize{
    
    // 保存
    [[NSUserDefaults standardUserDefaults] setObject:self.originalOutlineIdArray forKey:@"originalOutlineIdArray"];
    
    // 删除已经完成的下载任务
    [self deleteDownloadOriginalOutLineWithId:self.originalOutlineIdArray.lastObject];
    
}

// 增加一个下载任务
- (void)addDownloadOriginalOutLine:(NSDictionary *)dic{
    [self.downImageArray addObject:dic];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddOriginalOutline" object:nil userInfo:nil];
}

// 完成删除一个下载任务

- (void)deleteDownloadOriginalOutLineWithId:(NSString *)theId{
    
    for (int i = 0; i < self.downImageArray.count; i ++) {
        NSDictionary *dic = self.downImageArray[i];
        if ([dic.allKeys containsObject:theId]) {
            [self.downImageArray removeObjectAtIndex:i];
            // 保存成功之后, 发布一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveOriginalOutline" object:nil userInfo:nil];
        }
    }
    
    
}

@end
