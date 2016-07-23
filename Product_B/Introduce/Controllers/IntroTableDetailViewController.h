//
//  IntroTableDetailViewController.h
//  Product_B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroTableDetailModel.h"


@interface IntroTableDetailViewController : UIViewController

@property (nonatomic, strong)IntroTableDetailModel  *model;

@property (nonatomic, strong) NSString *avatar_l; // 原型头像
@property (nonatomic, strong) NSString *trackpoints_thumbnail_image;
@property (nonatomic, strong) NSString *auth;


@end
