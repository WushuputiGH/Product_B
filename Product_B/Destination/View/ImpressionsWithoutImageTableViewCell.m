//
//  ImpressionsWithoutImageTableViewCell.m
//  Product_B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 H. All rights reserved.
//

#import "ImpressionsWithoutImageTableViewCell.h"
#import "DeatinationDetailModel.h"
#import "Review.h"
#import "User.h"
#import <UIButton+WebCache.h>


@implementation ImpressionsWithoutImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
     self.backgroundColor = kTableViewColor;
    
    // 初始化星际评分视图
    self.starRatingView = [[HCSStarRatingView alloc] initWithFrame:self.starView.bounds];
    self.starRatingView.backgroundColor  = [UIColor clearColor];
    self.starRatingView.maximumValue = 5;
    self.starRatingView.minimumValue = 0;
    self.starRatingView.value = 0;
    self.starRatingView.tintColor = [UIColor redColor];
    self.starRatingView.enabled = NO;
    //    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.starView addSubview:self.starRatingView];
    
    self.iconButton.layer.cornerRadius = 25.0 / 2;
    self.iconButton.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfigureWithRow:(NSInteger)indexRow{
    
    DeatinationDetailModel *shareModel = [DeatinationDetailModel shareModel];
    NSArray *reviews = shareModel.theImpressions[@"reviews"];
    Review *review = reviews[indexRow];
    User *user = review.theUser;
    [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:user.avatar_s] forState:(UIControlStateNormal)];
    self.unameLabel.text = user.name;
    self.starRatingView.value = review.rating.integerValue;
    self.contentLabel.text = review.content;   
    
}

@end
