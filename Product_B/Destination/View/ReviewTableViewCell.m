//
//  ReviewTableViewCell.m
//  Product_B
//
//  Created by by wushuputi on 16/7/15.
//  Copyright © 2016年 H. All rights reserved.
//

#import "ReviewTableViewCell.h"
#import "ReviewListModel.h"
#import "Review.h"
#import "User.h"
#import <UIButton+WebCache.h>

@implementation ReviewTableViewCell

- (void)awakeFromNib {
    
     self.backgroundColor = kTableViewColor;
    // Initialization code
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
    
    self.iconButton.layer.cornerRadius = 30.0 / 2;
    self.iconButton.clipsToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellConfigureWithIndexRow:(NSInteger)indexRow{
    
    ReviewListModel *shareReviewListModel = [ReviewListModel shareReviewList];
    NSArray *reviews = shareReviewListModel.reviewList;
    Review *review = reviews[indexRow];
    self.reviewLabel.text = review.content;
    self.starRatingView.value = review.rating.integerValue;
    self.timeLabel.text = [[review.datetime componentsSeparatedByString:@" "] firstObject];
    User *user = review.theUser;
    self.unameLabel.text = user.name;
    [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:user.avatar_m] forState:(UIControlStateNormal)]; 
    
    
}



@end
