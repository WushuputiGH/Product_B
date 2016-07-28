//
//  IntroTableDetailCell.m
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroTableDetailCell.h"

@implementation IntroTableDetailCell

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
        self.imageV.layer.cornerRadius = 8;
        self.imageV.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imageV];
        
        self.textL = [[UILabel alloc] init];
        self.textL.numberOfLines = 0;
        self.textL.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.textL];
        
        self.timeImageV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.timeImageV];
        
        self.timeL = [[UILabel alloc] init];
        self.timeL.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.timeL];
        
        self.addressL = [[UILabel alloc] init];
        self.addressL.font = [UIFont systemFontOfSize:13];
        self.addressL.textColor = KCOLOR(0, 247, 255);
        [self.contentView addSubview:self.addressL];
        
    }
    
    return self;
}

- (void)cellConfigureTableDetailModel:(IntroTableDetailModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.photo] completed:nil];
    self.textL.text = model.text;
    self.timeImageV.image = [UIImage imageNamed:@"clock"];
    self.timeL.text = model.local_time;
    self.addressL.text = model.poi[@"name"];
    
    
//    CGFloat scale = model.photo_height.floatValue / model.photo_width.floatValue; // 宽高比例
  
    // 判断是否有图片
    if ([model.photo isEqualToString:@""]) // photo的网址是空的，没有图片
    {
        
        [self.imageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.width.equalTo(@0);
            make.height.equalTo(@0); // 将图片大小设为 0.
        }];
        
        
        [self.textL mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
//            make.top.equalTo(self.imageV.mas_bottom).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            
            
        }];
        
        [self.timeImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(3);
            make.top.equalTo(self.textL.mas_bottom).offset(3);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            
        }];
        
        [self.timeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeImageV.mas_right).offset(2);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        }];
        
        [self.addressL mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.textL.mas_bottom).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];

    }
    else // 有图片
    {
        [self.imageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.width.equalTo(@(KScreenWidth - 10));
            make.height.equalTo(self.imageV.mas_width).multipliedBy(3 / 3);
//            make.height.equalTo(self.imageV.mas_width).multipliedBy(scale); // 宽、高等比缩放 // 想要应用此步，要确保 scale 是有限小数！！！
        }];
        
        [self.textL mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageV.mas_bottom).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
        }];
        
        [self.timeImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(3);
            make.top.equalTo(self.textL.mas_bottom).offset(3);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            
        }];
        
        [self.timeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeImageV.mas_right).offset(2);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        }];
        
        [self.addressL mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.top.equalTo(self.textL.mas_bottom).offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
    }
    
}


@end
