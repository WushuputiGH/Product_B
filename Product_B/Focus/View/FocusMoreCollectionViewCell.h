//
//  FocusMoreCollectionViewCell.h
//  Product_B
//
//  Created by by wushuputi on 16/7/23.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearByListModel.h"

@interface FocusMoreCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;


- (void)cellCongifureWithNearByItem:(NearByItem *)neayByItem;

@end
