//
//  FocusThreeTableViewCell.m
//  Product_B
//
//  Created by by wushuputi on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusThreeTableViewCell.h"

@implementation FocusThreeTableViewCell

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
        self.focusViewThree = [[[NSBundle mainBundle] loadNibNamed:@"FocusView" owner:nil options:nil] firstObject];
        [self.contentView addSubview:self.focusViewThree];
    }
    return self;
}

- (void)cellConfigureWithFocus:(Focus *)focus{
    
    NearByItem *nearByItem1 = focus.dataList[0];
    [self.focusViewOne viewConfigureWithNearByItemS:nearByItem1];
    NearByItem *nearByItem2 = focus.dataList[1];
    [self.focusViewTwo viewConfigureWithNearByItemS:nearByItem2];
    NearByItem *nearByItem3 = focus.dataList[2];
    [self.focusViewThree viewConfigureWithNearByItemS:nearByItem3];
    
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height = (self.frame.size.height - 30) / 2;
    CGFloat width = (self.frame.size.width - 30) / 2;
    self.focusViewOne.frame = CGRectMake(10, 10, width, height);
    self.focusViewTwo.frame = CGRectMake(20 + width, 10, width, height);
    self.focusViewThree.frame = CGRectMake(10, 20 + height, width, height);

}


@end
