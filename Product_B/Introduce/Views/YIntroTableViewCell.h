//
//  IntroTableViewCell.h
//  Product_B
//
//  Created by by wushuputi on 16/7/12.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroMainTableModel.h"

@interface YIntroTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) IBOutlet UILabel *titleL;

@property (strong, nonatomic) IBOutlet UILabel *timeL;

@property (strong, nonatomic) IBOutlet UILabel *daysL;

@property (strong, nonatomic) IBOutlet UILabel *visitCountL;

@property (strong, nonatomic) IBOutlet UILabel *addressL;

@property (strong, nonatomic) IBOutlet UIImageView *userImageV;

@property (strong, nonatomic) IBOutlet UILabel *nameL;



- (void)cellConfigureTableModel:(IntroMainTableModel *)model;







@end
