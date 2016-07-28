//
//  ReviewListModel.h
//  Product_B
//
//  Created by by wushuputi on 16/7/15.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tag : NSObject

@property (nonatomic, strong, readwrite) NSNumber *tips_count;
@property (nonatomic, strong, readwrite) NSNumber *tagId;
@property (nonatomic, strong, readwrite) NSString *name;

@end


@interface ReviewListModel : NSObject

+ (ReviewListModel *)shareReviewList;

@property (nonatomic, strong, readwrite) NSString *postion;
@property (nonatomic, strong, readwrite) NSNumber *next_start;
@property (nonatomic, strong, readwrite) NSMutableArray *reviewList;
@property (nonatomic, strong, readwrite) NSMutableArray *tagList;


- (void)requestMoreData:(NSDictionary *)jsonDic;


@end
