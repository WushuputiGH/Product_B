//
//  Banners.h
//  Product_B
//
//  Created by wushuputi on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  广告
 */
@interface Banners : NSObject

@property (nonatomic, strong, readwrite) NSString *platform;
@property (nonatomic, strong, readwrite) NSString *image_url;
@property (nonatomic, strong, readwrite) NSString *html_url;


@end
