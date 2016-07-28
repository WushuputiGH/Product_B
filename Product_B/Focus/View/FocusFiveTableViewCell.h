//
//  FocusFiveTableViewCell.h
//  Product_B
//
//  Created by by wushuputi on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusFourTableViewCell.h"


@protocol FocusFiveTableViewCellMoreButton <NSObject>

- (void)touchMoreButton:(Focus *)focus;

@end

@interface FocusFiveTableViewCell : FocusFourTableViewCell

@property (nonatomic, strong, readwrite) UIButton *button;

@property (nonatomic, strong, readwrite) Focus *focus;

@property (nonatomic, assign, readwrite) id<FocusFiveTableViewCellMoreButton>  delegate;

@end
