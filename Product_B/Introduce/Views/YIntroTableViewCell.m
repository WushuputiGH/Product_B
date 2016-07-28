//
//  IntroTableViewCell.m
//  Product_B
//
//  Created by by wushuputi on 16/7/12.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "YIntroTableViewCell.h"

@implementation YIntroTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfigureTableModel:(IntroMainTableModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.cover_image] completed:nil];
    [self.userImageV sd_setImageWithURL:[NSURL URLWithString:model.user[@"avatar_l"]] completed:nil];
    self.titleL.text = model.name;
    self.timeL.text = model.first_day;
    self.daysL.text = [NSString stringWithFormat:@"%ld天",model.day_count];
    self.visitCountL.text = [NSString stringWithFormat:@"%ld次浏览", model.view_count];
    self.addressL.text = model.popular_place_str;
    self.nameL.text = [NSString stringWithFormat:@"by %@", model.user[@"name"]];
}


@end
