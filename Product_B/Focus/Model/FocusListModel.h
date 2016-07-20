//
//  FocusListModel.h
//  Product_B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Banners.h"
#import "Focus.h"

@interface FocusListModel : NSObject

@property (nonatomic, strong, readwrite) NSMutableArray *search_data;
@property (nonatomic, strong, readwrite) NSMutableArray <Banners *> *theBanners;
@property (nonatomic, strong, readwrite) NSMutableArray <Focus *> *theElements;
@property (nonatomic, strong, readwrite) NSNumber *last_modified;

@end
