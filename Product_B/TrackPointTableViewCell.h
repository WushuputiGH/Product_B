//
//  TrackPointTableViewCell.h
//  Product_B
//
//  Created by by wushuputi on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackPointTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) IBOutlet UILabel *theContent;
@property (strong, nonatomic) IBOutlet UILabel *theTime;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *theImageHeight;

@end
