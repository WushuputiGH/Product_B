//
//  OriginalTableViewCell.h
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OriginalItem.h"

@interface OriginalTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *timeAndWaypoints;
@property (strong, nonatomic) IBOutlet UIImageView *theImageview;
@property (strong, nonatomic) IBOutlet UILabel *viewCount;
@property (strong, nonatomic) IBOutlet UILabel *recommendations;
@property (strong, nonatomic) IBOutlet UILabel *total_comments_count;

@property (strong, nonatomic) IBOutlet UIView *theContainerView;

- (void)cellConfigureWithOriginalItemOutline:(OriginalItem *)originalItem;

- (void)cellConfigureWithImage:(UIImage *)image;

- (void)cellConfigureWithOriginalItem:(OriginalItem *)originalItem;


@end
