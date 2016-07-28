//
//  InformationTableViewCell.h
//  Product_B
//
//  Created by by wushuputi on 16/7/14.
//  Copyright © 2016年 H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic, strong, readwrite) NSArray *titleArray;
@property (nonatomic, strong, readwrite) NSDictionary *contenDic;


- (void)cellConfigureWithRow:(NSInteger)indexRow;


@end
