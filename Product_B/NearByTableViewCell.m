//
//  NearByTableViewCell.m
//  Product_B
//
//  Created by by wushuputi on 16/7/12.
//  Copyright © 2016年 H. All rights reserved.
//

#import "NearByTableViewCell.h"


@implementation NearByTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    // 初始化星际评分视图
    self.starRatingView = [[HCSStarRatingView alloc] initWithFrame:self.theStartView.bounds];
    self.starRatingView.backgroundColor  = [UIColor clearColor];
    self.starRatingView.maximumValue = 5;
    self.starRatingView.minimumValue = 0;
    self.starRatingView.value = 0;
    self.starRatingView.tintColor = [UIColor redColor];
    self.starRatingView.enabled = NO;
//    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.theStartView addSubview:self.starRatingView];
    
    
    self.backView.layer.cornerRadius = 20;
    self.theImageView.layer.cornerRadius = 20;
    self.theImageView.clipsToBounds = YES;
    self.backView.layer.borderWidth = 1;
    self.backView.layer.borderColor = [UIColor whiteColor].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellConfigureWith: (NearByItem *)nearByItem{
    
    if (nearByItem.cover_s == nil || [nearByItem.cover_s isEqualToString:@""]) {
        self.theImageView.image = kPlaceHolderImage2;
    }else{
        [self.theImageView sd_setImageWithURL:[NSURL URLWithString:nearByItem.cover_s] placeholderImage:kPlaceHolderImage2];
    }

    self.nameLabel.text = nearByItem.name;
    self.starRatingView.value = nearByItem.rating.floatValue;
    self.theTipsCountLabel.text = [NSString stringWithFormat:@"%ld人点评",  nearByItem.tips_count];
    self.theRecommendedLable.text = nearByItem.recommended_reason;
    self.theDistanceAndWishLabel.text = [NSString stringWithFormat:@"距离%0.1fkm / %ld人去过", nearByItem.distance, nearByItem.visited_count];
}


@end
