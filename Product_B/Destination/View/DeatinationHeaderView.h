//
//  DeatinationHeaderView.h
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeatinationHeaderView : UITableViewHeaderFooterView

// 这个自定义分区头包含一个可以拉伸的imageView
@property (nonatomic, strong, readwrite) UIImageView *theStretchImage;

// 包含一个位于下面中心, 可以点解button
@property (nonatomic, strong, readwrite) UIButton *theButton;




@end
