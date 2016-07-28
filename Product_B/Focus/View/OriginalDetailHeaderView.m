//
//  OriginalDetailHeaderView.m
//  Product_B
//
//  Created by by wushuputi on 16/7/18.
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
   
    [self configureTextWithOriginalDetailModel:model];
    
    [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.theUser.avatar_m] forState:(UIControlStateNormal)];
    self.iconButton.layer.cornerRadius = 25;
    self.iconButton.clipsToBounds = YES;
    
    [self.theImageView sd_setImageWithURL:[NSURL URLWithString:model.trackpoints_thumbnail_image]];
    self.theImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.theImageView.clipsToBounds = YES;
}

- (void)viewConfigureWithOriginalDetailModelOutline: (OriginalDetailModel *)model{
    [self configureTextWithOriginalDetailModel:model];

    [self.iconButton setBackgroundImage:[UIImage imageWithData:model.theUser.avatar_m_Data] forState:(UIControlStateNormal)];
    self.iconButton.layer.cornerRadius = 25;
    self.iconButton.clipsToBounds = YES;
    
    self.theImageView.image = [UIImage imageWithData:model.trackpoints_thumbnail_image_Data];
    
    self.theImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.theImageView.clipsToBounds = YES;
    
}

- (void)configureTextWithOriginalDetailModel:(OriginalDetailModel *)model{
    self.title.text = model.name;
    self.name.text = model.theUser.name;
    self.time.text = model.first_day.description;
    self.daysCount.text = model.day_count.description;
    self.miles.text = model.mileage.description;
    self.liker.text = model.recommendations.description;

}




@end
