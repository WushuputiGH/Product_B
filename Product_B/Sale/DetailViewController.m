//
//  DetailViewController.m
//  0000000
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 by wushuputikeji. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (nonatomic,strong)UIWebView *webView;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"详情页面";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:item];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    UIScrollView *scrollView = (UIScrollView *)[[self.webView subviews]objectAtIndex:0];
    scrollView.bounces = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    NSString *url = [NSString stringWithFormat:@"http://web.breadtrip.com/hunter/product/%@/",_product];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    

}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
