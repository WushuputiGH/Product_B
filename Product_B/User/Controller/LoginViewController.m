//
//  LoginViewController.m
//  Product_B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 H. All rights reserved.
//

#import "LoginViewController.h"
#import <TFHpple.h>
#import <TFHppleElement.h>
#import "NSObject+ArchiverUser.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
         self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}



- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
         self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 监听用户归档通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveUser) name:@"SaveUser" object:nil];
}
- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)login:(UIButton *)sender {
    
    NSString *urlString = @"http://web.breadtrip.com/accounts/login/?next=/";
    
    NSDictionary *parDic = @{@"username":self.uname.text,
                             @"password":self.password.text};
    
    [RequestManager requestManager:urlString requestType:(RequestPOST) queryDictionary:parDic finish:^(NSData *data) {
        
        
        TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:data];
        // 获取节点
        NSArray *dataArray = [hpple searchWithXPathQuery:@"//div"];
        for (TFHppleElement *hppleElement in dataArray) {
            if ([hppleElement.attributes[@"class"] isEqualToString:@"name"]) {
                NSArray *childernArray = hppleElement.children; // <a href="/u/2384408471/">chenhong6</a>
                for (TFHppleElement *childern in childernArray) {
                    if ([childern.tagName isEqualToString:@"a"]) {
                        // 获取id
                        NSArray *stringArray = [childern.attributes[@"href"] componentsSeparatedByString:@"/"];
                        NSString *theIdString = stringArray[2];
                        // 获取childern的子节点的内容
                        NSString *userName = childern.firstChild.content;

                        NSLog(@"%@ %@", userName, theIdString);
                        // 获取用户信息, 并归档
                         [NSObject getUserInfoAndArchiver];
                        return ;
                    }
                }
            }
        }
        
        // 若果出现问题, 弹出提示框
    
        NSArray *dataArray2 = [hpple searchWithXPathQuery:@"//p"];
        NSMutableString *errorString = [NSMutableString string];
        for (TFHppleElement *hppleElement in dataArray2) {
            if ([hppleElement.attributes[@"class"] isEqualToString:@"error"]){
                if (hppleElement.text != nil) {
                   [errorString appendString:hppleElement.text];
                }
            }
        }
        [self alertWithString:errorString];
    } error:^(NSError *error) {
        
    }];

}

#pragma mark ---监听用户归档信息---
- (void)saveUser{
    // pop到最初界面
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}


#pragma mark ---- 提示框 ----

- (void)alertWithString:(NSString *)string{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:string preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:done];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
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
