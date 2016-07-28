//
//  IntroStoryDetailViewController.h
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroStoryCollectModel.h"
#import "IntroCollectDetailModel.h"

@interface IntroStoryDetailViewController : UIViewController

@property (nonatomic, strong) NSString *naviName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *avatar_l;
@property (nonatomic, strong) NSString *spot_id;

@property (nonatomic, strong) NSString *introduce; // 尾视图自我介绍

@property (nonatomic, assign) BOOL isMain; // 用于判断是从主界面点击进来的还是从二级页面collectView 点进来的


@property (nonatomic, strong) IntroStoryCollectModel *model;

@end
