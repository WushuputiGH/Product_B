//
//  FocusCollectionViewCell.m
//  Product_B
//
//  Created by by wushuputi on 16/7/17.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusCollectionViewCell.h"

@implementation FocusCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = kTableViewColor;
    
    // 初始化星际评分视图
   
    self.starRatingView = [[HCSStarRatingView alloc] initWithFrame:self.theStarView.bounds];
    self.starRatingView.backgroundColor  = [UIColor clearColor];
    self.starRatingView.maximumValue = 5;
    self.starRatingView.minimumValue = 0;
    self.starRatingView.value = 0;
    self.starRatingView.tintColor = [UIColor redColor];
    self.starRatingView.enabled = NO;
    self.starRatingView.allowsHalfStars = YES;
    self.starRatingView.accurateHalfStars = YES;
    
    
    //    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.theStarView addSubview:self.starRatingView];
    self.theStarView.clipsToBounds = YES;
    self.theStarView.backgroundColor = [UIColor clearColor];

    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
  
    NSLog(@"%@", NSStringFromCGRect(self.theStarView.bounds));
    NSLog(@"%@", NSStringFromCGRect(self.theStarView.frame));
 
    [self.starRatingView layoutIfNeeded];
}


@end
