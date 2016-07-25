//
//  MyTableViewCell.m
//  0000000
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanoukeji. All rights reserved.
//

#import "MyTableViewCell.h"


@implementation MyTableViewCell

- (void)copydata:(Preduct *)model{
    [self.PicImageview sd_setImageWithURL:[NSURL URLWithString:model.title_page] completed:nil];
    [self.PersonImage sd_setImageWithURL:[NSURL URLWithString:model.avatar_l] completed:nil];
    self.PersonImage.layer.cornerRadius = 39;
    self.PersonImage.layer.masksToBounds = YES;
    self.titleLable.text = model.title;
    self.priceLable.text = [NSString stringWithFormat:@"$%@",model.price];
//    [self.priceLable setTextColor:[UIColor orangeColor]];
    self.bigLable.text = [NSString stringWithFormat:@"%@ ,%@ ,%ld人喜欢",model.date_str,model.address,(long)model.like_count];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
