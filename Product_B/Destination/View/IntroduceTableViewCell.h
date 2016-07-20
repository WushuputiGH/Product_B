//
//  IntroduceTableViewCell.h
//  Product_B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroduceTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLable;

@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UILabel *commentCountLable;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLable;
@property (nonatomic, strong, readwrite) HCSStarRatingView *starRatingView;


- (void)cellConfigure;

@end
