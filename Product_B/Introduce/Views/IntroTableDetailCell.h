//
//  IntroTableDetailCell.h
//  Product_B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroTableDetailModel.h"

@interface IntroTableDetailCell : UITableViewCell


@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *textL;

@property (nonatomic, strong) UIImageView *timeImageV;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *addressL;

- (void)cellConfigureTableDetailModel:(IntroTableDetailModel *)model;






@end
