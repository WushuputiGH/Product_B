//
//  DeatinationHeaderView.m
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import "DeatinationHeaderView.h"
#import "DeatinationDetailModel.h"


@implementation DeatinationHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    // 获取model单例
    DeatinationDetailModel *shareModel = [DeatinationDetailModel shareModel];
    
    NSLog(@"%@", NSStringFromCGRect(self.frame));
    
    self.theStretchImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.theStretchImage];
    [self.theStretchImage sd_setImageWithURL:[NSURL URLWithString:shareModel.cover_route_map_cover]];

    
    
    self.theButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:self.theButton];
//    self.theButton.backgroundColor = [UIColor orangeColor];
    // 定义button的背景颜色以及圆角
    self.theButton.layer.cornerRadius = 15;
    self.theStretchImage.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - 15);
    self.theStretchImage.contentMode = UIViewContentModeScaleAspectFill;
    self.theStretchImage.clipsToBounds = YES;
    self.theButton.frame = CGRectMake(self.frame.size.width / 2 - 15, self.frame.size.height - 30, 30, 30);
//    [self.theButton setImage:[UIImage imageNamed:@"xiaohei" ]forState:(UIControlStateNormal)];
    [self.theButton setBackgroundImage:[UIImage imageNamed:@"xiaohei" ] forState:UIControlStateNormal];
    
    self.theButton.hidden = YES;

    
//    // 添加约束
//    [self.theStretchImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left);
//        make.right.equalTo(self.contentView.mas_right);
//        //            make.height.equalTo(self.theStretchImage.mas_width).multipliedBy(24.0 / 38);
//        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
//    }];
//    
//    [self.theButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.contentView.mas_centerX);
//        make.centerY.equalTo(self.contentView.mas_bottom).offset(-15);
//        make.height.width.equalTo(@30);
//    }];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.theStretchImage.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height - 15);
     self.theButton.frame = CGRectMake(self.frame.size.width / 2 - 15, self.frame.size.height - 30, 30, 30);
 
    
}


@end
