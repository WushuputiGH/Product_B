//
//  OriginalTableViewCell.m
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalTableViewCell.h"

@implementation OriginalTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfigureWithOriginalItem:(OriginalItem *)originalItem{
    [self configureTextWithOriginalItem:originalItem];
    [self.theImageview sd_setImageWithURL:[NSURL URLWithString:originalItem.cover_image_default]];
}


- (void)cellConfigureWithOriginalItemOutline:(OriginalItem *)originalItem{
    [self configureTextWithOriginalItem:originalItem];
    self.theImageview.image = [UIImage imageWithData:originalItem.cover_image_default_Data];
}

- (void)configureTextWithOriginalItem:(OriginalItem *)originalItem{
    
    [self showText];
    self.name.text = originalItem.name;
    // 首先将时间戳转化成时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:originalItem.date_added.doubleValue];
    NSString *dateString = [[date.description componentsSeparatedByString:@" "] firstObject];
    self.timeAndWaypoints.text  = [NSString stringWithFormat:@"%@  %@足迹", dateString, originalItem.waypoints];
    self.viewCount.text = [NSString stringWithFormat:@"%@浏览", originalItem.view_count];
    self.recommendations.text = [NSString stringWithFormat:@"%@喜欢", originalItem.recommendations];
    self.total_comments_count.text = [NSString stringWithFormat:@"%@评论", originalItem.total_comments_count];
}

- (void)cellConfigureWithImage:(UIImage *)image{
    self.theImageview.image = image;
    [self hideText];
}

- (void)hideText{
    self.name.hidden = YES;
    self.timeAndWaypoints.hidden = YES;
    self.theContainerView.hidden = YES;
}

- (void)showText{
    self.name.hidden = NO;
    self.timeAndWaypoints.hidden = NO;
    self.theContainerView.hidden = NO;
}

@end
