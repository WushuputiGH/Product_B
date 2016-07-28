//
//  ImpressionsWithoutImageTableViewCell.h
//  Product_B
//
//  Created by by wushuputi on 16/7/14.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImpressionsWithoutImageTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *iconButton;
@property (strong, nonatomic) IBOutlet UILabel *unameLabel;

@property (strong, nonatomic) IBOutlet UIView *starView;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, strong, readwrite) HCSStarRatingView *starRatingView;


- (void)cellConfigureWithRow:(NSInteger)indexRow;

@end
