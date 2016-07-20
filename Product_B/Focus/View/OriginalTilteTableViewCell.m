//
//  OriginalTilteTableViewCell.m
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalTilteTableViewCell.h"

@implementation OriginalTilteTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)theButtonAction:(UIButton *)sender {
}

- (void)cellCongifureWithOriginalDetailModel:(OriginalDetailModel *)model{
    self.spotLabel.text = [NSString stringWithFormat:@"%@ 景点", model.sights];
    self.restaurantLabel.text = [NSString stringWithFormat:@"%@ 餐饮", model.restaurant];
    self.hotelLabel.text = [NSString stringWithFormat:@"%@ 景点", model.hotel];
    self.shopLabel.text = [NSString stringWithFormat:@"%@ 景点", model.mall];
    
    // 获取途经国家
    NSArray *nameArray = [model.covered_countries valueForKeyPath:@"name"];
    self.routLineLabel.text = [nameArray componentsJoinedByString:@"."];
    
}
@end
