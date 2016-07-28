//
//  BannerTableViewCell.h
//  Product_B
//
//  Created by wushuputi on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Banners.h"
@interface BannerTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *theImageView;


- (void)cellConfigiureWithBanners:(Banners *)banners;

@end
