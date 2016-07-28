//
//  Master.h
//  Product_B
//
//  Created by by wushuputi on 16/7/21.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Master : NSObject


@property (nonatomic, strong, readwrite) User *user;



+ (Master *)defaultMaster;

@end
