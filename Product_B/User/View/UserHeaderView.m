//
//  UserHeaderView.m
//  Product_B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 H. All rights reserved.
//

#import "UserHeaderView.h"

@implementation UserHeaderView


- (void)viewConfigureWithUser:(User*)user{
    
    [self.iconButton setBackgroundImage:[UIImage imageWithData:user.avatar_l_Data] forState:(UIControlStateNormal)];
    
    self.iconButton.layer.cornerRadius = 75.0 / 2;
    self.iconButton.clipsToBounds = YES;
    
    self.uname.text = user.name;
    self.brief.text = user.user_desc;
    
}

- (IBAction)iconButton:(UIButton *)sender {
}

@end
