//
//  RequestManager.m
//  DouBanProgarm
//
//  Created by by wushuputi on 16/5/23.
//  Copyright © 2016年 an. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

+(void)requestManager:(NSString *)urlString finish:(Finish)finish error:(Error)error
{
    RequestManager *requestManager = [[RequestManager alloc] init];
    [requestManager requestManager:urlString finish:finish error:error];
}
-(void)requestManager:(NSString *)urlString finish:(Finish)finish error:(Error)error
{
    self.finish = finish;
    self.error = error;
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10;

#warning 设置了请求头
    [request setValue:@"BreadTravel/6.6.2/zh (iPhone8,2; iPhone OS9.3.1; zh-Hans zh_CN)" forHTTPHeaderField:@"User-Agent"];
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task =
    [session
     dataTaskWithRequest:request
     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         if (error) {
             self.error(error);
         }
         else
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.finish(data);
             });
         }
        
     }];
    [task resume];
}


//
+(void)requestManager:(NSString *)urlString requestType:(RequestType)requestType queryDictionary:(NSDictionary *)queryDictionary finish:(Finish)finish error:(Error)error
{
    RequestManager *requstManager = [[RequestManager alloc] init];
    [requstManager requestManager:urlString requestType:requestType queryDictionary:queryDictionary finish:finish error:error];
}

-(void)requestManager:(NSString *)urlString requestType:(RequestType)requestType queryDictionary:(NSDictionary *)queryDictionary finish:(Finish)finish error:(Error)error
{
   
    if (requestType == RequestGET) {
        
        [self requestManager:urlString finish:finish error:error];
    }
    else
    {
        self.finish = finish;
        self.error = error;
        NSURL *url =[NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.timeoutInterval = 10;
        [request setHTTPMethod:@"POST"];
        if (queryDictionary.count > 0) {
            [request setHTTPBody:[self queryDictionaryToQueryData:queryDictionary]];
        }
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                self.error(error);
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.finish(data);
                });
            }
            
        }];
        [task resume];
    }

}


-(NSData *)queryDictionaryToQueryData:(NSDictionary *)queryDictionary
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *key in queryDictionary) {
        NSString *string = [NSString stringWithFormat:@"%@=%@", key, queryDictionary[key]];
        [array addObject:string];
    }
    NSString *queryString = [array componentsJoinedByString:@"&"];
    NSData *queryData = [queryString dataUsingEncoding:(NSUTF8StringEncoding)];
    return queryData;
}

@end
