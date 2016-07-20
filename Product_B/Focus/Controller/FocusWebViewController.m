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

@interface FocusWebViewController ()<WKNavigationDelegate>

// webView
@property (nonatomic, strong)WKWebView *theWebView;

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
        _theWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _theWebView.navigationDelegate = self;
//        _theWebView.UIDelegate = self;
    }
    return _theWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.theWebView];
    [self.theWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
   
}


#pragma mark ---wkWebView的代理----
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    
    NSLog(@"%@", navigationAction.request.URL);
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
