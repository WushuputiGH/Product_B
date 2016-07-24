//
//  FocusFiveTableViewCell.m
//  Product_B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusFiveTableViewCell.h"

@implementation FocusFiveTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.contentView addSubview:self.button];
        self.button.titleLabel.font = [UIFont systemFontOfSize:25];
        [self.button setTitle:@"More ......" forState:(UIControlStateNormal)];
        [self.button addTarget:self action:@selector(more:) forControlEvents:(UIControlEventTouchUpInside)];
        self.tintColor = [UIColor blackColor];
    
    }
    return self;
}



- (void)cellConfigureWithFocus:(Focus *)focus{
    [super cellConfigureWithFocus:focus];
    self.focus = focus;
}

#pragma  mark ----点击更多按钮-----
- (void)more:(UIButton *)button{
    
    [self.delegate touchMoreButton:self.focus];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat labelH = 30;
    CGFloat labelW = self.frame.size.width - 20;
    CGFloat height = (self.frame.size.height - 40 - labelH) / 2;
    CGFloat width = (self.frame.size.width - 30) / 2;
    self.focusViewOne.frame = CGRectMake(10, 10, width, height);
    self.focusViewTwo.frame = CGRectMake(20 + width, 10 , width, height);
    self.focusViewThree.frame = CGRectMake(10, 20 + height, width, height);
    self.focusViewFour.frame = CGRectMake(20 + width, 20 + height, width, height);
    self.button.frame = CGRectMake(10, 30 + 2 * height, labelW, labelH);
    
}






@end
