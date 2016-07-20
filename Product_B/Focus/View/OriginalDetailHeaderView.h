//
//  OriginalDetailHeaderView.h
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OriginalDetailModel.h"

@interface OriginalDetailHeaderView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) IBOutlet UIButton *iconButton;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *daysCount;
@property (strong, nonatomic) IBOutlet UILabel *miles;
@property (strong, nonatomic) IBOutlet UILabel *liker;

- (void)viewConfigureWithOriginalDetailModel: (OriginalDetailModel *)model;

@end
