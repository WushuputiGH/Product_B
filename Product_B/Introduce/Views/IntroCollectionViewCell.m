//
//  IntroCollectionViewCell.m
//  Product_B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroCollectionViewCell.h"

@implementation IntroCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)cellConfigureCollectModel:(IntroMainCollectModel *)model
{
    [self.ImageV sd_setImageWithURL:[NSURL URLWithString:model.index_cover] completed:nil];
    [self.userImageV sd_setImageWithURL:[NSURL URLWithString:model.avatar_l] completed:nil];
    self.nameL.text = model.name;
}


- (void)storyCellConfigureCollectModel:(IntroStoryCollectModel *)model
{
    [self.ImageV sd_setImageWithURL:[NSURL URLWithString:model.index_cover] completed:nil];
    [self.userImageV sd_setImageWithURL:[NSURL URLWithString:model.user[@"avatar_l"]] completed:nil];
    self.nameL.text = model.user[@"name"];
}

@end
