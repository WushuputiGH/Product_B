//
//  BannerTableViewCell.m
//  Product_B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import "BannerTableViewCell.h"

@implementation BannerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellConfigiureWithBanners:(Banners *)banners{
    [self.theImageView sd_setImageWithURL:[NSURL URLWithString:banners.image_url]];
//    self.backgroundColor = [UIColor orangeColor];
}

@end
