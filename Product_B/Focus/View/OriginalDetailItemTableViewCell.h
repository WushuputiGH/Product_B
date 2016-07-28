//
//  OriginalDetailItemTableViewCell.h
//  Product_B
//
//  Created by by wushuputi on 16/7/19.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Waypoint.h"

@interface OriginalDetailItemTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *locationButton;

@property (nonatomic, strong, readwrite) NSNumber *lat;
@property (nonatomic, strong, readwrite) NSNumber *lng;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *hight;

@property (nonatomic, assign, readwrite) CGFloat aspect;


- (void)cellCoinfigureWithWaypoint: (Waypoint *)waypoint;
- (void)cellCoinfigureWithWaypointOutline: (Waypoint *)waypoint;

@end
