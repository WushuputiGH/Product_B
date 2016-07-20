//
//  IntroduceTableViewCell.m
//  Product_B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import "IntroduceTableViewCell.h"
#import "DeatinationDetailModel.h"

@implementation IntroduceTableViewCell

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)cellConfigure{
    
    // 首先获取shareModel
    DeatinationDetailModel *shareModel = [DeatinationDetailModel shareModel];
    
    self.nameLable.text = shareModel.name;
    self.starRatingView.value = shareModel.rating.integerValue;
    self.commentCountLable.text = [NSString stringWithFormat:@"%ld人评论", shareModel.tips_count];
    self.descriptionLable.text = shareModel.theDescription;

}

@end
