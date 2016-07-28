//
//  IntroCollectionViewCell.h
//  Product_B
//
//  Created by by wushuputi on 16/7/12.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroMainCollectModel.h"
#import "IntroStoryCollectModel.h"

@interface IntroCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *ImageV;

@property (strong, nonatomic) IBOutlet UIImageView *userImageV;


@property (strong, nonatomic) IBOutlet UILabel *nameL;

- (void)cellConfigureCollectModel:(IntroMainCollectModel *)model;


- (void)storyCellConfigureCollectModel:(IntroStoryCollectModel *)model;


@end
