//
//  AutotHeight.h
//  UI12_UITableViewCell
//
//  Created by lanou on 16/5/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AutotHeight : NSObject
// 用来计算字符串的高度
+ (CGFloat)autoHeightByString:(NSString *)text width:(CGFloat)width font:(CGFloat)font;

@end
