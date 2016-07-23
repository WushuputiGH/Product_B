//
//  IntroMainScrollModel.h
//  Product_B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroMainScrollModel : NSObject

@property (nonatomic, strong) NSString *ImgSrc;
@property (nonatomic, strong) NSString *BannerName;
@property (nonatomic, strong) NSDictionary *Category;
@property (nonatomic, strong) NSString *CategoryValue;
@property (nonatomic, strong) NSString *Link;


+ (NSMutableArray *)IntroScrollModelConfigureJsonDic:(NSDictionary *)JsonDic;


@end
