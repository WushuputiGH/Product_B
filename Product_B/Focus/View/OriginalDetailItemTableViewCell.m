//
//  OriginalDetailItemTableViewCell.m
//  Product_B
//
//  Created by by wushuputi on 16/7/19.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalDetailItemTableViewCell.h"

@implementation OriginalDetailItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.aspect = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellCoinfigureWithWaypoint: (Waypoint *)waypoint{
    
    [self.theImageView sd_setImageWithURL:[NSURL URLWithString:waypoint.photo]];
    // 获取图片的比例
    [self configureTextWithWaypoint:waypoint];
    
    
}

- (void)cellCoinfigureWithWaypointOutline: (Waypoint *)waypoint{
    [self.theImageView sd_setImageWithURL:[NSURL URLWithString:waypoint.photo]];
    self.theImageView.image = [UIImage imageWithData:waypoint.photoData];
    // 获取图片的比例
    [self configureTextWithWaypoint:waypoint];
}


- (void)configureTextWithWaypoint: (Waypoint *)waypoint{
    CGFloat aspect;
    if ( waypoint.photo_info[@"w"] == nil || [waypoint.photo_info[@"w"] floatValue] == 0) {
        aspect = 0;
    }else{
        aspect = [waypoint.photo_info[@"h"] floatValue] / [waypoint.photo_info[@"w"] floatValue];
    }
    
    self.aspect = aspect;
    CGFloat weight = self.theImageView.frame.size.width;
    self.hight.constant = weight * self.aspect;
    
    self.contentLabel.text = waypoint.text;
    self.timeLabel.text = waypoint.local_time;
    
    [self.locationButton setTitle:waypoint.city forState:(UIControlStateNormal)];
    self.lat = waypoint.location[@"lat"];
    self.lng = waypoint.location[@"lng"];
}
@end
