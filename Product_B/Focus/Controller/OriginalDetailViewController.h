//
//  OriginalDetailViewController.h
//  Product_B
//
//  Created by by wushuputi on 16/7/19.
//  Copyright © 2016年 H. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "OriginalItem.h"
#import "OriginalDetailModel.h"
#import "OriginalDetailHeaderView.h"
#import "OriginalTableViewCell.h"
#import "OriginalDetailItemTableViewCell.h"
#import "OriginalTilteTableViewCell.h"
#import "OriginalOutLine.h"
#import "OriginalOutLineId.h"

@interface OriginalDetailViewController : UIViewController

@property (nonatomic, strong, readwrite) NSString *thePlaceId;
@property (nonatomic, strong, readwrite) NSNumber *theplaceType;
@property (nonatomic, strong, readwrite) NSNumber *theOriginalItemId;

@property (nonatomic, strong, readwrite) OriginalItem *originalItem; // 用于归档

@property (nonatomic, strong, readwrite) UIImage *downImage; // 用于正在下载的照片


@property (strong, nonatomic)UITableView *theTableView;
@property (strong, nonatomic)OriginalDetailModel *originalDetailModel;

@end
