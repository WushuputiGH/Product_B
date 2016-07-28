//
//  FocusOneTableViewCell.m
//  Product_B
//
//  Created by by wushuputi on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusOneTableViewCell.h"

@implementation FocusOneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.focusViewOne = [[[NSBundle mainBundle] loadNibNamed:@"FocusView" owner:nil options:nil] firstObject];
        [self.contentView addSubview:self.focusViewOne];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KLightGreen;
    }
    return self;
}

- (void)cellConfigureWithFocus:(Focus *)focus{
    NearByItem *nearItem = focus.dataList[0];
    [self.focusViewOne viewConfigureWithNearByItemL:nearItem];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.focusViewOne.frame = CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 20);
}

@end
