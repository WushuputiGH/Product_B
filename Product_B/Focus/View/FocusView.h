//
//  FocusView.h
//  Product_B
//
//  Created by by wushuputi on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearByListModel.h"

@interface FocusView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong, readwrite) NearByItem *neatByItem;


- (IBAction)tapAction:(UITapGestureRecognizer *)sender;

- (void)viewConfigureWithNearByItemL: (NearByItem *)nearByItem;
- (void)viewConfigureWithNearByItemS: (NearByItem *)nearByItem;
@end
