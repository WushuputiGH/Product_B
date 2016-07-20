//
//  NearByTableViewCell.h
//  Product_B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearByListModel.h"

@interface NearByTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) IBOutlet UIView *theStartView;
@property (strong, nonatomic) IBOutlet UILabel *theRecommendedLable;
@property (strong, nonatomic) IBOutlet UILabel *theTipsCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *theDistanceAndWishLabel;

@property (nonatomic, strong, readwrite) HCSStarRatingView *starRatingView;


- (void)cellConfigureWith: (NearByItem *)nearByItem;


@end
