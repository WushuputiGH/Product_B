//
//  NearByNavigationBar.m
//  Product_B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 H. All rights reserved.
//

#import "NearByNavigationBar.h"

@implementation NearByNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = KLightGreen;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = KLightGreen;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KLightGreen;
    }
    return self;
}


- (void)changeFrameWithIndex:(NSInteger)Index{
    
    // 获取对应Button的frame
    
    
    
    
    
}



@end
