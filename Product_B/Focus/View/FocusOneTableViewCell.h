//
//  FocusOneTableViewCell.h
//  Product_B
//
//  Created by by wushuputi on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusView.h"
#import "Focus.h"

@interface FocusOneTableViewCell : UITableViewCell

@property (nonatomic, strong, readwrite) FocusView *focusViewOne;

- (void)cellConfigureWithFocus:(Focus *)focus;

@end
