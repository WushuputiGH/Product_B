//
//  UserViewController.m
//  Product_B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 H. All rights reserved.
//

#import "UserViewController.h"
#import "Master.h"
#import "OriginalOutLineId.h"
#import "OriginalOutLine.h"
#import "NSObject+ArchiverUser.h"
#import "OriginalTableViewCell.h"
#import "UserHeaderView.h"
#import "OriginalDetailOutlineViewController.h"
#import "SetUserViewController.h"


@interface UserViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *theImageViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *theImageTop;
@property (strong, nonatomic)UITableView *theTableView;

@property (strong, nonatomic)Master *defaultMaster;

@property (strong, nonatomic)NSMutableArray *originalOutlines;

@property (strong, nonatomic)UIViewController *theVc;

@end

@implementation UserViewController

- (UITableView *)theTableView{
    
    
    if (!_theTableView) {
        _theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 60) style:(UITableViewStylePlain)];
        _theTableView.dataSource = self;
        _theTableView.delegate = self;
        _theTableView.backgroundColor = [UIColor clearColor];
        
        [_theTableView registerNib:[UINib nibWithNibName:@"OriginalTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"originalTableViewCell"];
    }
    return _theTableView;
    
}

- (UIViewController *)theVc{
    if (!_theVc) {
        _theVc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Notlogged"];
    }
    return _theVc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    self.originalOutlines = [NSMutableArray array];
    self.defaultMaster = [Master defaultMaster];
    
    // 监听两个通知, 一个是添加下载任务的通知, 一个是下载完成的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addOriginalOutline) name:@"AddOriginalOutline" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveOriginalOutline) name:@"SaveOriginalOutline" object:nil];
    
    
    [self.view addSubview:self.theTableView];
   
    [self.view addSubview:self.theVc.view];
    [self addChildViewController:self.theVc];
    self.theVc.view.hidden = YES;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUser];
    [self.theTableView reloadData];

    // 
    
    
}

#pragma mark -----监听消息-------
- (void)addOriginalOutline{
    [self.theTableView reloadData];
}

- (void)saveOriginalOutline{
    [self unarchiverOriginalOutline];
    [self.theTableView reloadData];
    
}

- (void)getUser{
#pragma mark --- 从文件中获取用户登录信息 ---
    self.defaultMaster.user = [NSObject unarchiverUser];
    if (self.defaultMaster.user == nil) {
        self.theVc.view.hidden = NO;
    }else {
        self.theVc.view.hidden = YES;
        
        // 设置背景墙图片
        NSData *imageData = self.defaultMaster.user.coverData;
        UIImage *backgroundImage = [UIImage imageWithData:imageData];
        self.theImageView.image = backgroundImage;
        // 反归档保存的下载内容
        [self unarchiverOriginalOutline];
        
    }
}

#pragma mark ---反归档已经保存的下载内容---

- (void)unarchiverOriginalOutline{
    
    [self.originalOutlines removeAllObjects];
    // 首先获取OriginalOutline的所有id
    NSArray *keys = [OriginalOutLineId defaultOriginalOutlineIdArray].originalOutlineIdArray;
    
    for (NSString *key in keys) {
        NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:key];
        OriginalOutLine *modle = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.originalOutlines addObject:modle];
    }
}




#pragma mark ------tableView的代理方法------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    
    if (section == 1) {
        return self.originalOutlines.count;
    }
    return  [OriginalOutLineId defaultOriginalOutlineIdArray].downImageArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        return cell;
    }
    if (indexPath.section == 1) {
        OriginalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"originalTableViewCell" forIndexPath:indexPath];
        OriginalOutLine *originalOutLine = self.originalOutlines[indexPath.row];
        [cell cellConfigureWithOriginalItemOutline:originalOutLine.originalItem];
        return cell;
    }else{
        OriginalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"originalTableViewCell" forIndexPath:indexPath];
        
        NSDictionary *imageDic =[OriginalOutLineId defaultOriginalOutlineIdArray].downImageArray[indexPath.row];
        UIImage *image = imageDic[imageDic.allKeys[0]];
      
        [cell cellConfigureWithImage:image];
        return cell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
       UserHeaderView *header = [[[NSBundle mainBundle] loadNibNamed:@"UserHeaderView" owner:nil options:nil] firstObject];
        [header viewConfigureWithUser:self.defaultMaster.user];
        [header.setButton addTarget:self action:@selector(setAction:) forControlEvents:(UIControlEventTouchUpInside)];
        return header;
    }else{
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        header.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width - 20, 20)];
        [header addSubview:label];
        if (section == 1) {
            label.text = @"离线收藏";
        }
        if (section == 2) {
            label.text = @"正在下载";
        }
       
        return header;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 0;
    }else{
        if (indexPath.section == 1) {
             return 150;
        }else{
            return 200;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 200;
    }else{
        return 30;
    }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        OriginalDetailOutlineViewController *originalOutlineVC = [[OriginalDetailOutlineViewController alloc] init];
        OriginalOutLine *originalOutLine = self.originalOutlines[indexPath.row];
        originalOutlineVC.originalDetailModel = originalOutLine.originalDetailModel;
        [originalOutlineVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:originalOutlineVC animated:YES];
    }
    
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%lf", offsetY);
    
    if (offsetY >= 0) {
        self.theImageTop.constant = - offsetY;
        self.theImageViewHeight.constant = 200;
    }else{
        self.theImageViewHeight.constant = 200 - offsetY;
        self.theImageTop.constant = 0;
    }
    
    
    
}




#pragma mark ---点解设置按钮的时候---

- (void)setAction:(UIButton *)button{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出账户" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *loginout = [UIAlertAction actionWithTitle:@"退出" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        self.theVc.view.hidden = NO;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"User"];
        [self logout];
        
    }];
    UIAlertAction *set = [UIAlertAction actionWithTitle:@"设置账户" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        SetUserViewController *setUserVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"setUser"];
        [self.navigationController pushViewController:setUserVC animated:YES];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:loginout];
    [alert addAction:set];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark ---注销登录---
- (void)logout{
    
    NSString *urlString = @"http://web.breadtrip.com/accounts/logout/";
    
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        
    } error:^(NSError *error) {
        
    }];
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIViewController *viewController = segue.destinationViewController;
    viewController.hidesBottomBarWhenPushed = YES;
    
    
    
}


@end
