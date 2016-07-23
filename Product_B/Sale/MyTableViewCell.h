//
//  MyTableViewCell.h
//  0000000
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Preduct.h"

@interface MyTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *PicImageview;
@property (strong, nonatomic) IBOutlet UILabel *titleLable;
@property (strong, nonatomic) IBOutlet UILabel *bigLable;
@property (strong, nonatomic) IBOutlet UIImageView *PersonImage;

@property (strong, nonatomic) IBOutlet UILabel *priceLable;

- (void)copydata:(Preduct *)model;



@end
