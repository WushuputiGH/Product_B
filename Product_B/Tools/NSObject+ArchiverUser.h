//
//  NSObject+ArchiverUser.h
//  Product_B
//
//  Created by by wushuputi on 16/7/21.
//  Copyright © 2016年 H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface NSObject (ArchiverUser)


+ (void)archiverUserWithId:(NSNumber *)theId;

+ (void)archiverUser:(User *)user;

+ (User *)unarchiverUser;

#pragma mark ---获取登陆信息, 并且归档---
+ (void)getUserInfoAndArchiver;

@end
