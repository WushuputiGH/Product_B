//
//  RequestManager.h
//  DouBanProgarm
//
//  Created by by wushuputi on 16/5/23.
//  Copyright © 2016年 an. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Finish)(NSData *data);
typedef void (^Error) (NSError *error);

//定义一个解析类型的枚举
typedef NS_ENUM(NSInteger, RequestType)
{
    RequestGET, // GET解析
    RequestPOST // POST解析
    
};


@interface RequestManager : NSObject

@property (nonatomic, copy, readwrite) Finish finish;
@property (nonatomic, copy, readwrite) Error error;

+(void)requestManager:(NSString *)urlString finish:(Finish )finish error:(Error)error;
-(void)requestManager:(NSString *)urlString finish:(Finish )finish error:(Error)error;

+(void)requestManager:(NSString *)urlString requestType:(RequestType)requestType queryDictionary:(NSDictionary *)queryDictionary finish:(Finish)finish error:(Error)error;
-(void)requestManager:(NSString *)urlString requestType:(RequestType)requestType queryDictionary:(NSDictionary *)queryDictionary finish:(Finish)finish error:(Error)error;

@end
