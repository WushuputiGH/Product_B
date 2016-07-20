//
//  InformationTableViewCell.m
//  Product_B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 H. All rights reserved.
//

#import "InformationTableViewCell.h"
#import "DeatinationDetailModel.h"

@implementation InformationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = kTableViewColor;
    self.titleArray = @[@"概况", @"地址", @"到达方式", @"开放时间", @"门票价格", @"联系方式"];
    self.contenDic = @{@"概况":@"theDescription",
                       @"地址": @"address",
                       @"到达方式": @"arrival_type",
                       @"开放时间": @"opening_time",
                       @"门票价格": @"fee",
                       @"联系方式": @"tel"
                       };
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellConfigureWithRow:(NSInteger)indexRow{
    DeatinationDetailModel *shareModel = [DeatinationDetailModel shareModel];
    NSString *title = self.titleArray[indexRow];
    self.titleLabel.text = title;
    self.contentLabel.text = [shareModel valueForKey: self.contenDic[title]];
}






@end
