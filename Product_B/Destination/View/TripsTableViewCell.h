//
//  TripsTableViewCell.h
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *iconButton;
@property (strong, nonatomic) IBOutlet UILabel *unameLable;
@property (strong, nonatomic) IBOutlet UILabel *spotTextLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *theScrollerView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

- (void)cellConfigureWithIndexRow: (NSInteger)indexRow;

@end
