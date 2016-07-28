//
//  ReviewTableViewCell.h
//  Product_B
//
//  Created by by wushuputi on 16/7/15.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *iconButton;
@property (strong, nonatomic) IBOutlet UILabel *unameLabel;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *reviewLabel;

@property (nonatomic, strong, readwrite) HCSStarRatingView *starRatingView;

- (void)cellConfigureWithIndexRow: (NSInteger)indexRow;



@end
