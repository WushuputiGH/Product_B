//
//  IntroScrollWebViewController.m
//  Product_B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroScrollWebViewController.h"

@interface IntroScrollWebViewController ()

@property (nonatomic, strong) UIWebView *webView;


@end

@implementation IntroScrollWebViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KCOLOR(255, 255, 255);
    self.navigationItem.title = self.naviName;

    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 0, KScreenWidth - 10, KScreenHeight - 64)];

    NSURL *url = [NSURL URLWithString:self.link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    
//    [self.webView loadHTMLString:self.link baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
    [self.view addSubview:self.webView];
    
    
    // Do any additional setup after loading the view.
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
