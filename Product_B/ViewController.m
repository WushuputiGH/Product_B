//
//  ViewController.m
//  Product_B
//
//  Created by by wushuputi on 16/7/12.
//  Copyright © 2016年 H. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) IBOutlet UILabel *theContent;

@property (strong, nonatomic) IBOutlet UILabel *theAuthor;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) UIViewController *tabBarVC;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.theImageView.alpha = 0;
    self.theContent.alpha = 0;
    self.theAuthor.alpha = 0;

    self.tabBarVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tabBarVC"];
    [self.view addSubview:self.tabBarVC.view];
    [self addChildViewController:self.tabBarVC];
    self.tabBarVC.view.alpha = 0;
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        self.loginButton.layer.cornerRadius = 30;
        self.loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.loginButton.layer.borderWidth = 1;
        
        self.theImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.theImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.theImageView.layer.borderWidth = 5;
        self.theImageView.layer.cornerRadius = 15;
        [self requestData];
    });
    
    
    
}


- (void)requestData{
    
    NSString *urlString = @"http://v3.wufazhuce.com:8000/api/hp/more/0";
    [YRequestManager requestWithUrlString:urlString parDic:nil requestType:(RequestGET) finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSArray *dataArray = jsonDic[@"data"];
        NSDictionary *oneDay = dataArray[0];
        [self.theImageView sd_setImageWithURL:[NSURL URLWithString:oneDay[@"hp_img_url"]]];
        NSString *content = oneDay[@"hp_content"];
        if ([content containsString:@"by"]) {
            NSArray *contentArray = [content componentsSeparatedByString:@"by"];
            self.theContent.text = contentArray[0];
            self.theAuthor.text = [NSString stringWithFormat:@"---by%@", contentArray[1]];
        }else{
            if ([content containsString:@"from"]) {
                NSArray *contentArray = [content componentsSeparatedByString:@"from"];
                self.theContent.text = contentArray[0];
                self.theAuthor.text = [NSString stringWithFormat:@"---from%@", contentArray[1]];
            }else{
                self.theContent.text = content;
            }
        }
    
        [UIView animateKeyframesWithDuration:1 delay:0 options:3 animations:^{
            self.theImageView.alpha = 1;
            self.theContent.alpha = 1;
            self.theAuthor.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        
        
    } error:^(NSError *error) {
        
    }];
    
    
}



- (IBAction)login:(UIButton *)sender {
    
    [UIView animateWithDuration:0.8 animations:^{
        self.theImageView.alpha = 0;
        self.theContent.alpha = 0;
        self.theAuthor.alpha = 0;
        self.loginButton.alpha = 0;
       
    } completion:^(BOOL finished) {
        
        [self.theImageView removeFromSuperview];
        [self.theAuthor removeFromSuperview];
        [self.theContent removeFromSuperview];
        [self.loginButton removeFromSuperview];
        
        [UIView animateWithDuration:0.8 animations:^{
            self.tabBarVC.view.alpha = 1;
            
        } completion:^(BOOL finished) {
        }];
    }];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
