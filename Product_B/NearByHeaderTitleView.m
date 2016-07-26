//
//  NearByHeaderTitleView.m
//  Product_B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 H. All rights reserved.
//

#import "NearByHeaderTitleView.h"

@implementation NearByHeaderTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = KLightGreen;
    }
    return self;
}

@end
