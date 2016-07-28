//
//  IntroCollectDetailModel.h
//  Product_B
//
//  Created by by wushuputi on 16/7/15.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroCollectDetailModel : NSObject

@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong,) NSNumber *photo_height;
@property (nonatomic, strong) NSNumber *photo_width;
@property (nonatomic, strong) NSDictionary *poi;





+ (NSMutableArray *)collectDetailModelConfigureJsonDic:(NSDictionary *)JsonDic;


@end
