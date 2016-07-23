//
//  IntroCollectStoryDetailCell.m
//  Product_B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroCollectStoryDetailCell.h"

@implementation IntroCollectStoryDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc] init];
        self.imageV.contentMode = UIViewContentModeScaleAspectFit;
        self.imageV.layer.cornerRadius = 8;
        self.imageV.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imageV];
        
        self.textL = [[UILabel alloc] init];
        self.textL.numberOfLines = 0;
        [self.contentView addSubview:self.textL];
    }
    return self;
}

- (void)cellConfigureCollectDetailModel:(IntroCollectDetailModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] completed:nil];
    
    self.textL.text = model.text;
    
    CGFloat scale = model.photo_height.floatValue / model.photo_width.floatValue; // 宽高比例
    
    // 判断是否有文字
    if ([model.text isEqualToString:@""]) // text的网址是空的，没有字符串
    {
        [self.imageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.height.equalTo(self.imageV.mas_width).multipliedBy(scale); // 宽、高等比缩放
            

            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];
        
        
        [self.textL mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageV.mas_bottom).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.width.equalTo(@0);
            make.height.equalTo(@0);
        }];
        
    }
    else // 有文字
    {
        [self.imageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.top.equalTo(self.contentView.mas_top).offset(10);
//            make.width.equalTo(@(KScreenWidth - 10));
//            make.height.equalTo(self.imageV.mas_width).multipliedBy(3 / 3);
             make.height.equalTo(self.imageV.mas_width).multipliedBy(scale); // 宽、高等比缩放
        }];
        
        [self.textL mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageV.mas_bottom).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        }];
        
    }

    
    
    
    
}




@end
