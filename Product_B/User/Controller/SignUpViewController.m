//
//  SignUpViewController.m
//  User
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 H. All rights reserved.
//

#import "SignUpViewController.h"
#import "RequestManager.h"
#import "SetUserViewController.h"
#import <TFHpple.h>
#import <TFHppleElement.h>
#import <WebKit/WebKit.h>

@interface SignUpViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *uname;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *captcha;
@property (strong, nonatomic) IBOutlet UIImageView *captchaImage;

@property (strong, nonatomic) IBOutlet UILabel *emailCheck;
@property (strong, nonatomic) IBOutlet UILabel *unameCheck;

@property (strong, nonatomic) IBOutlet UILabel *passwordCheck;
@property (strong, nonatomic) IBOutlet UILabel *chatChaCheck;

@property (strong, nonatomic)NSArray *checkStrings;


@property (nonatomic, strong)WKWebView *webView;

@end

@implementation SignUpViewController


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

    
#pragma mark ---每次运行之前, 清除cookie, 清除上一次保存的记录----
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }

    self.checkStrings = @[@"email", @"username"];
    
//    [self requestSignup];
//    [self requestMessage_count];
    [self requestChatcha];
    
    // 移除containerView, 调价到scrollerview上面
    
//    UIScrollView *theScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    theScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 300);
//    [self.containerView removeFromSuperview];
//    [theScrollView addSubview:self.containerView];
//    [self.view addSubview:theScrollView];
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)requestChatcha{
    NSString *urlSting = @"http://web.breadtrip.com/captcha.jpg";
    [RequestManager requestManager:urlSting finish:^(NSData *data) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
        UIImage *image = [UIImage imageWithData:data];
        
        self.captchaImage.image = image;
        
    } error:^(NSError *error) {
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)captcha:(UITapGestureRecognizer *)sender {
    
    [self requestChatcha];
}

- (IBAction)signUp:(UIButton *)sender {
    
    NSString *urlString = @"http://web.breadtrip.com/accounts/signup/";
    
    NSDictionary *parDic = @{@"email": self.email.text,
                             @"username": self.uname.text,
                             @"password": self.password.text,
                             @"captcha": [self.captcha.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                             };
    
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

                        // 获取设置界面
                        SetUserViewController *setUserVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"setUser"];
//                        [self presentViewController:setUserVC animated:YES completion:nil];
                        [self.navigationController pushViewController:setUserVC animated:YES];
                        return ;
                    }
                }
            }
        }
        
        NSArray *dataArray2 = [hpple searchWithXPathQuery:@"//span"];
        for (TFHppleElement *hppleElement in dataArray2) {
            if ([hppleElement.attributes[@"class"] isEqualToString:@"error"]){
                if (hppleElement.text != nil) {
                    self.chatChaCheck.text = [self.chatChaCheck.text stringByAppendingString:hppleElement.text];
                }
            }
        }

 
    } error:^(NSError *error) {
        
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    // 获取tag值
    
    NSInteger tag = textField.tag;
    
    if (tag == 12 || tag == 13) {
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://web.breadtrip.com/accounts/check_%@/?%@=%@", self.checkStrings[tag - 10], self.checkStrings[tag - 10], textField.text];
    
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        UILabel *label = [self.view viewWithTag:tag +10];
        if( [jsonData[@"error"]  isKindOfClass:[NSNull class]])
        {
            label.text = @"";
        }else{
            label.text = jsonData[@"error"];
        }
        
    } error:^(NSError *error) {
        
    }];
}


- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
- (void)requestMessage_count{
    NSString *urlSting = @"http://web.breadtrip.com/message_count/";
    [RequestManager requestManager:urlSting finish:^(NSData *data) {
        
    } error:^(NSError *error) {
        
    }];
}


- (void)requestSignup{
    NSString *urlSting = @"http://web.breadtrip.com/accounts/signup/";
    [RequestManager requestManager:urlSting finish:^(NSData *data) {
        
    } error:^(NSError *error) {
        
    }];
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
