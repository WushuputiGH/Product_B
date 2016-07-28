//
//  NSObject+ArchiverUser.m
//  Product_B
//
//  Created by by wushuputi on 16/7/21.
//  Copyright © 2016年 H. All rights reserved.
//

#import "NSObject+ArchiverUser.h"
#import <TFHpple.h>
#import <TFHppleElement.h>


@implementation NSObject (ArchiverUser)


+ (void)archiverUserWithId:(NSNumber *)theId{
    
    // 首先进行网络请求
    NSString *urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/v2/users/%@/", theId];
    
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        User *user = [[User alloc] init];
        [user setValuesForKeysWithDictionary:[jsonDic valueForKeyPath:@"data.user_info"]];
        // 归档
        [self archiverUser:user];
        
    } error:^(NSError *error) {
    }];
}

+ (void)archiverUser:(User *)user{
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"User"];
    // 发布用户归档通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveUser" object:nil userInfo:nil];
    NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(9, 1, 1) firstObject]);
}

+ (User *)unarchiverUser{
    
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"User"];
    
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return user;
}

#pragma mark ---获取登陆信息, 并且归档---
+ (void)getUserInfoAndArchiver{
    
    // 进行请求
    NSString *urlString = @"http://web.breadtrip.com/";
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        // 获取返回的html信息
//        NSString *htmlString = [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
        TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:data];
        
        // 获取节点
        NSArray *dataArray = [hpple searchWithXPathQuery:@"//div"];
        for (TFHppleElement *hppleElement in dataArray) {
            if ([hppleElement.attributes[@"class"] isEqualToString:@"name"]) {
                NSLog(@"%@", hppleElement.text);
                NSArray *childernArray = hppleElement.children; // <a href="/u/2384408471/">chenhong6</a>
                
                
                for (TFHppleElement *childern in childernArray) {
                    if ([childern.tagName isEqualToString:@"a"]) {
                        // 获取id
                        NSArray *stringArray = [childern.attributes[@"href"] componentsSeparatedByString:@"/"];
                        NSString *theIdString = stringArray[2];
                        // 获取childern的子节点的内容
//                        NSString *userName = childern.firstChild.content;
                        
#pragma mark --- // 根据id获取user, 并归档信息 ----
                        [self requsetUser:@([theIdString integerValue])];
                    }
                }
            }
        }
    } error:^(NSError *error) {
    }];
}

#pragma mark --- 使用sessionid获取用户登录信息, 并归档 ---
+ (void)requsetUser:(NSNumber *)theId{
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/v2/users/%@/", theId];
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        User *user = [[User alloc] init];
        [user setValuesForKeysWithDictionary:[jsonDic valueForKeyPath:@"data.user_info"]];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            user.avatar_l_Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.avatar_l]];
        });
        
        dispatch_group_async(group, queue, ^{
            user.avatar_s_Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.avatar_s]];
        });
        dispatch_group_async(group, queue, ^{
            user.avatar_m_Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.avatar_m]];
        });
        dispatch_group_async(group, queue, ^{
            user.coverData = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.cover]];
        });
        
        dispatch_group_notify(group, queue, ^{
            // 归档
            [self archiverUser:user];
        });
        
    
   
        
    } error:^(NSError *error) {
    }];
}



@end
