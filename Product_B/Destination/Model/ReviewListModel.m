//
//  ReviewListModel.m
//  Product_B
//
//  Created by by wushuputi on 16/7/15.
//  Copyright © 2016年 H. All rights reserved.
//

#import "ReviewListModel.h"
#import "Review.h"



@implementation Tag 

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.tagId = value;
    }
}

@end


static ReviewListModel *shareReviewList = nil;
@implementation ReviewListModel


+ (ReviewListModel *)shareReviewList{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareReviewList = [[ReviewListModel alloc] init];
    });
    return shareReviewList;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"tips"]) {
        self.reviewList = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            Review *review = [[Review alloc] init];
            [review setValuesForKeysWithDictionary:dic];
            [self.reviewList addObject:review];
        }
    }
    if ([key isEqualToString:@"tags"]) {
        self.tagList = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            Tag *tag = [[Tag alloc] init];
            [tag setValuesForKeysWithDictionary:dic];
            [self.tagList addObject:tag];
        }
    }
}


- (void)requestMoreData:(NSDictionary *)jsonDic{
    
    ReviewListModel *newModel = [[ReviewListModel alloc] init];
    [newModel setValuesForKeysWithDictionary:jsonDic];
    self.postion = newModel.postion;
    self.next_start = newModel.next_start;
    [self.tagList addObjectsFromArray:newModel.tagList];
    [self.reviewList addObject:newModel.reviewList];
    
}







@end
