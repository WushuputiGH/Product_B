//
//  IntroCollectStoryDetailCell.h
//  Product_B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroCollectDetailModel.h"

@interface IntroCollectStoryDetailCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *textL;


- (void)cellConfigureCollectDetailModel:(IntroCollectDetailModel *)model;


@end
