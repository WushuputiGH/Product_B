//
//  AutotHeight.m
//  UI12_UITableViewCell
//
//  Created by wushuputi on 16/5/12.
//  Copyright © 2016年 by wushuputi. All rights reserved.
//

#import "AutotHeight.h"

@implementation AutotHeight


+ (CGFloat)autoHeightByString:(NSString *)text width:(CGFloat)width font:(CGFloat)font{
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    
   CGFloat h = [text boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    
    return h;
}







@end
