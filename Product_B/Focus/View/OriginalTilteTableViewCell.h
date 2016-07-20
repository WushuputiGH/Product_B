//
//  OriginalTilteTableViewCell.h
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OriginalDetailModel.h"

@interface OriginalTilteTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *spotLabel;
@property (strong, nonatomic) IBOutlet UILabel *restaurantLabel;
@property (strong, nonatomic) IBOutlet UILabel *hotelLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopLabel;
@property (strong, nonatomic) IBOutlet UILabel *routLineLabel;
@property (strong, nonatomic) IBOutlet UIButton *covered_countriesButton;

- (IBAction)theButtonAction:(UIButton *)sender;

- (void)cellCongifureWithOriginalDetailModel:(OriginalDetailModel *)model;


@end
