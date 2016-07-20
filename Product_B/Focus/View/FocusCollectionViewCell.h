//
//  FocusCollectionViewCell.h
//  Product_B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FocusCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIView *theStarView;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;

@property (nonatomic, strong, readwrite) HCSStarRatingView *starRatingView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *starViewHeight;

@end
