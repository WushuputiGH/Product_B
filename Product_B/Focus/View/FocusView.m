//
//  FocusView.m
//  Product_B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusView.h"

@implementation FocusView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)viewConfigureWithNearByItemS:(NearByItem *)nearByItem{
    
    self.neatByItem = nearByItem;
    
    self.nameLabel.text = nearByItem.name;
    [self.theImageView sd_setImageWithURL:[NSURL URLWithString:nearByItem.cover_s]];
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    
    // 当被点击的时候, 发送一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FOCUSVIEWTAP" object:nil userInfo:@{@"nearBtItem": self.neatByItem}];
    
    
}

- (void)viewConfigureWithNearByItemL:(NearByItem *)nearByItem{
    
    self.neatByItem = nearByItem;
    
    self.nameLabel.text = nearByItem.name;
    [self.theImageView sd_setImageWithURL:[NSURL URLWithString:nearByItem.cover_route_map_cover]];
}
@end
