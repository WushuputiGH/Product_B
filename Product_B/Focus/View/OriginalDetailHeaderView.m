//
//  OriginalDetailHeaderView.m
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalDetailHeaderView.h"
#import <UIButton+WebCache.h>
@implementation OriginalDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)viewConfigureWithOriginalDetailModel:(OriginalDetailModel *)model{
    self.title.text = model.name;
    self.name.text = model.theUser.name;
    
    [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.theUser.avatar_m] forState:(UIControlStateNormal)];
    self.iconButton.layer.cornerRadius = 25;
    self.iconButton.clipsToBounds = YES;
    
    self.time.text = model.first_day.description;
    self.daysCount.text = model.day_count.description;
    self.miles.text = model.mileage.description;
    self.liker.text = model.recommendations.description;
    
    [self.theImageView sd_setImageWithURL:[NSURL URLWithString:model.trackpoints_thumbnail_image]];
    self.theImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.theImageView.clipsToBounds = YES;
}






@end
