//
//  FocusWebViewController.m
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusWebViewController.h"
#import <WebKit/WebKit.h>
#import "NearByListModel.h"
#import "DestinationViewController.h"

@interface FocusWebViewController ()<WKNavigationDelegate, WKUIDelegate>

// webView
@property (nonatomic, strong)WKWebView *theWebView;
@property (nonatomic, assign)BOOL isFirstLoad;

@end

@implementation FocusWebViewController


- (WKWebView *)theWebView{
    if (!_theWebView) {
        NSString *js = @"var count = document.images.length;for (var i = 0; i < count; i++) {var image = document.images[i];image.style.width=320;};window.alert('找到' + count + '张图');";
        // 根据JS字符串初始化WKUserScript对象
        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        [config.userContentController addUserScript:script];
        _theWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + 0) configuration:config];
        _theWebView.navigationDelegate = self;
        _theWebView.UIDelegate = self;
//        _theWebView.UIDelegate = self;
    }
    return _theWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.theWebView];
    
    // 下面所写的代码, 均是用来欺骗webview的, 用来判断是否是第一次加载, 已经是否是第一次加载. 上面也有假的view;
//   [self.theWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://huang.ziyang"]]];
//    self.isFirstLoad = YES;
//    
//    UIView *theView = [[UIView alloc] initWithFrame:self.view.bounds];
//    theView.backgroundColor = KLightGreen;
//    [self.view addSubview:theView];
    
    [self.theWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
//


#pragma mark ---wkWebView的代理----
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    
    NSLog(@"%@", navigationAction.request.URL);
    
//    if ([navigationAction.request.URL.absoluteString isEqualToString:@"https://huang.ziyang"]) {
//        if (self.isFirstLoad) {
//            decisionHandler(WKNavigationActionPolicyAllow);
//            self.isFirstLoad = NO;
//            return;
//        }else{
//            decisionHandler(WKNavigationActionPolicyCancel);
//            [self.navigationController popViewControllerAnimated:YES];
//            return;
//        }
//    }
    
    
    if ([navigationAction.request.URL.absoluteString hasPrefix:@"app:jump:webview:"]) {
        NSString *url = [navigationAction.request.URL.absoluteString stringByReplacingOccurrencesOfString:@"app:jump:webview:" withString:@""];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [webView loadRequest:request];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if ([navigationAction.request.URL.absoluteString hasPrefix:@"app:jump:place:destination"]) {
        
        NearByItem *nearByItem = [[NearByItem alloc] init];
        
        NSString *string = navigationAction.request.URL.absoluteString;
        
        NSArray *array = [string componentsSeparatedByString:@"/"];
        nearByItem.type = @([array[2] integerValue]);
        nearByItem.nearByItemId = @([[[[array lastObject] componentsSeparatedByString:@":"] firstObject] integerValue]);
        
        DestinationViewController *destinationVC = [[DestinationViewController alloc] init];
        destinationVC.nearByItem = nearByItem;
        [self.navigationController pushViewController:destinationVC animated:YES];
        

        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

/*
 
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"1");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"2");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"3");
    NSLog(@"%@", webView.URL);
    NSLog(@"%@", error.description);
    
    NSString *urlString = [NSString stringWithFormat:@"%@", error.userInfo[@"NSErrorFailingURLKey"]];
    
    
    if ([urlString isEqualToString:@"https://huang.ziyang/"]) {
        [self.theWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"4");
  
    
}

//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
//       NSLog(@"5");
//}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"6");
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
     NSLog(@"7");
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"8");
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    NSLog(@"9");
    return webView;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    completionHandler();
    NSLog(@"10");
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
   
    NSLog(@"11");
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    NSLog(@"12");
}

- (void)webViewDidClose:(WKWebView *)webView{
    NSLog(@"13");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
