//
//  RequestManager.h
//  UI18LessonCocoapods
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 ycw. All rights reserved.
//

#import <Foundation/Foundation.h>
//这个类基于对AFNetworking的一个二次封装
//之前我们请求的方式使用NSURLSession 现在我们请求的方式变成AFNetworking

//请求方式的枚举
//typedef NS_ENUM(NSInteger,RequestType){
//    RequestGET,  //GET请求
//    RequestPOST   //POST请求
//};

//请求成功回调的block
typedef void (^Finish)(NSData *data);

//请求失败回调的block
typedef void (^Error)(NSError *error);

@interface YRequestManager : NSObject
//block属性
@property(nonatomic,copy)Finish finish;
@property(nonatomic,copy)Error error;

//给controller提供的接口 传进来字符串网址 字典 请求类型 成功block 失败block
+(void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(RequestType )requestType finish:(Finish)finish error:(Error)error;

//  根据传来的start值进行页面刷新
- (void)getTourMainDataWithStart:(NSString *)startID parDic:(NSDictionary *)parDic requestType:(RequestType)requestType finish:(Finish)finish error:(Error)error;




@end
