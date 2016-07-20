//
//  FocusTwoTableViewCell.m
//  Product_B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusTwoTableViewCell.h"

@implementation FocusTwoTableViewCell

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
        self.focusViewTwo = [[[NSBundle mainBundle] loadNibNamed:@"FocusView" owner:nil options:nil] firstObject];
        [self.contentView addSubview:self.focusViewTwo];

   
    }
    return self;
}

- (void)cellConfigureWithFocus:(Focus *)focus{

    [super cellConfigureWithFocus:focus];
    NearByItem *nearByItem = focus.dataList[1];
    [self.focusViewTwo viewConfigureWithNearByItemL:nearByItem];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.focusViewOne.frame = CGRectMake(10, 10, self.frame.size.width - 20, (self.frame.size.height - 30) / 2 );
    self.focusViewTwo.frame = CGRectMake(10, 20 + (self.frame.size.height - 30) / 2 , self.frame.size.width - 20, (self.frame.size.height - 30) / 2 );

}

@end
