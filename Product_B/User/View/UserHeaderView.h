//
//  UserHeaderView.h
//  Product_B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserHeaderView : UIView
@property (strong, nonatomic) IBOutlet UIButton *iconButton;
@property (strong, nonatomic) IBOutlet UILabel *uname;
@property (strong, nonatomic) IBOutlet UILabel *brief;
@property (strong, nonatomic) IBOutlet UIButton *setButton;


- (void)viewConfigureWithUser:(User*)user;

@end
