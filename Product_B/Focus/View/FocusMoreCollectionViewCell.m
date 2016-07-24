//
//  FocusMoreCollectionViewCell.m
//  Product_B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusMoreCollectionViewCell.h"

@implementation FocusMoreCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.theImageView.layer.cornerRadius = 20;
    self.theImageView.clipsToBounds = YES;
}


- (void)cellCongifureWithNearByItem:(NearByItem *)neayByItem{
    [self.theImageView sd_setImageWithURL:[NSURL URLWithString:neayByItem.cover_s] placeholderImage:[UIImage imageNamed:@"placeHolder3"]];
    self.nameLabel.text = neayByItem.name;
}

@end
