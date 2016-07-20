//
//  ImpressionsTableViewCell.h
//  Product_B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImpressionsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *iconButton;
@property (strong, nonatomic) IBOutlet UILabel *unameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *theScrollview;


- (void)cellConfigureWithIndexRow: (NSInteger)indexRow;

@end
