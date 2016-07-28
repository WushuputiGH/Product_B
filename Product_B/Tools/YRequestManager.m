//
//  RequestManager.m
//  UI18LessonCocoapods
//
//  Created by by wushuputi on 16/6/16.
//  Copyright © 2016年 ycw. All rights reserved.
//

#import "YRequestManager.h"


@implementation YRequestManager


+(void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(RequestType )requestType finish:(Finish)finish error:(Error)error
{
    YRequestManager*manager = [[YRequestManager alloc]init];
    [manager requestWithUrlString:urlString parDic:parDic requestType:requestType finish:finish error:error];
  
    
}


-(void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic requestType:(RequestType )requestType finish:(Finish)finish error:(Error)error
{
    //block赋值
    self.finish = finish;
    self.error = error;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (requestType == RequestGET) {
        [manager GET:urlString parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self finishRequestReturnMainThread:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.error(error);
        }];
        return;
    }
    [manager POST:urlString parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self finishRequestReturnMainThread:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.error(error);
    }];
}

-(void)finishRequestReturnMainThread:(NSData *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.finish(data);
    });
}




// by hqx 1024 根据传来的start值进行页面刷新
- (void)getTourMainDataWithStart:(NSString *)startID parDic:(NSDictionary *)parDic requestType:(RequestType)requestType finish:(Finish)finish error:(Error)error
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/index/?next_start=%@",startID]];
    NSString *urlString = [url absoluteString];
    
    //block赋值
    self.finish = finish;
    self.error = error;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (requestType == RequestGET) {
        [manager GET:urlString parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self finishRequestReturnMainThread:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.error(error);
        }];
        return;
    }
    [manager POST:urlString parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self finishRequestReturnMainThread:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.error(error);
    }];

}


// by hqx 1024 根据传来的start值 对全部故事界面进行更新
//- (void)getStoryDataWithStart:(NSInteger)startID passValue:(PassValue)passValue
//{
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/new_trip/spot/hot/list/?start=%ld",startID]] ;
//    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        if (data != nil) {
//            NSDictionary *allDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//            
//            self.TourDataDict = [allDict valueForKey:@"data"];
//            
//            passValue(self.TourDataDict);
//        }
//        else
//            passValue(nil);
//        
//    }];
//}




@end
