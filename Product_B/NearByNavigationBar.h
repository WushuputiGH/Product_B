//
//  NearByNavigationBar.h
//  Product_B
//
//  Created by by wushuputi on 16/7/15.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByNavigationBar : UIView
@property (strong, nonatomic) IBOutlet UIButton *allButton;
@property (strong, nonatomic) IBOutlet UIButton *scenicButton;
@property (strong, nonatomic) IBOutlet UIButton *hotelButton;
@property (strong, nonatomic) IBOutlet UIButton *restaurantButton;
@property (strong, nonatomic) IBOutlet UIButton *entertainmentButton;

@property (strong, nonatomic) IBOutlet UIButton *shopButton;

// 根据下标, 更改frame;
- (void)changeFrameWithIndex: (NSInteger)Index;



@end
