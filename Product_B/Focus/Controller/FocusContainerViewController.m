//
//  FocusContainerViewController.m
//  Product_B
//
//  Created by by wushuputi on 16/7/16.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusContainerViewController.h"
#import "FocusListModel.h"
#import "BannerTableViewCell.h"
#import "FocusOneTableViewCell.h"
#import "FocusTwoTableViewCell.h"
#import "FocusThreeTableViewCell.h"
#import "FocusFourTableViewCell.h"
#import "FocusFiveTableViewCell.h"
#import "BannerWebViewController.h"
#import "FocusPlaceDetaliViewController.h"
#import "FocusMoreViewController.h"
#import <WebKit/WebKit.h>

@interface FocusContainerViewController () <UITableViewDataSource, UITableViewDelegate, FocusFiveTableViewCellMoreButton>
@property (nonatomic, strong, readwrite)FocusListModel *focusListModel;
@property (nonatomic, strong, readwrite)UITableView *theTableView;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, strong) UIView *headerTitleView;

@end


@implementation FocusContainerViewController

- (UITableView *)theTableView{
    if (!_theTableView) {
        _theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _screenWidth, _screenHeight - 64) style:(UITableViewStylePlain)];
        _theTableView.dataSource = self;
        _theTableView.delegate = self;
        
        [_theTableView registerNib:[UINib nibWithNibName:@"BannerTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"bannnerTableViewCell"];
        [_theTableView registerClass:[FocusOneTableViewCell class] forCellReuseIdentifier:@"focusOneTableViewCell"];
        [_theTableView registerClass:[FocusTwoTableViewCell class] forCellReuseIdentifier:@"focusTwoTableViewCell"];
        [_theTableView registerClass:[FocusThreeTableViewCell class] forCellReuseIdentifier:@"focusThreeTableViewCell"];
        [_theTableView registerClass:[FocusFourTableViewCell class] forCellReuseIdentifier:@"focusFourTableViewCell"];
        [_theTableView registerClass:[FocusFiveTableViewCell class] forCellReuseIdentifier:@"focusFiveTableViewCell"];
        _theTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _theTableView.backgroundColor = KLightGreen;
        
    }
    return _theTableView;
}

- (FocusListModel *)focusListModel{
    if (! _focusListModel ) {
        _focusListModel = [[FocusListModel alloc] init];
    }
    return _focusListModel;
}


- (UIView *)headerTitleView{
    
    if (!_headerTitleView) {
        _headerTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        _headerTitleView.backgroundColor = KLightGreen;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100, 20, 200, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"精彩推荐";
        label.font = [UIFont systemFontOfSize:17 weight:1.5];
        label.textColor = [UIColor whiteColor];
        [_headerTitleView addSubview:label];
    }
    return _headerTitleView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    [self.view addSubview:self.theTableView];
    [self requsetData];
    
    [self.navigationController.navigationBar addSubview:self.headerTitleView];
    
    // 监听focusView被点击的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(focusViewTap:) name:@"FOCUSVIEWTAP" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.headerTitleView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.headerTitleView.hidden = YES;
}

#pragma mark ---数据请求---

- (void)requsetData{
    
    // http://api.breadtrip.com/destination/v3/?last_modified_since=0
    NSString *urlString  = @"http://api.breadtrip.com/destination/v3/?last_modified_since=0";
    
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData: data options:(NSJSONReadingMutableContainers) error:nil];
        [self.focusListModel setValuesForKeysWithDictionary:jsonDic];
        
        [self.theTableView reloadData];
        
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --- tableView的代理方法----



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 + self.focusListModel.theElements.count;
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.focusListModel.theBanners.count;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        BannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bannnerTableViewCell" forIndexPath:indexPath];
        [cell cellConfigiureWithBanners:self.focusListModel.theBanners[indexPath.row]];
        return cell;
    }else{
        
        // 首先获取每个section中有多少个data
        NSInteger count = self.focusListModel.theElements[indexPath.section - 1].dataList.count;
        switch (count) {
            case 1:
            {
                FocusOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"focusOneTableViewCell" forIndexPath:indexPath];
                [cell cellConfigureWithFocus:self.focusListModel.theElements[indexPath.section - 1]];
                return cell;
                break;
            }
            case 2:{
                FocusTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"focusTwoTableViewCell" forIndexPath:indexPath];
                [cell cellConfigureWithFocus:self.focusListModel.theElements[indexPath.section - 1]];
                return cell;
                break;
            }
            case 3:{
                
            }
            case 4:{
                Focus *focus = self.focusListModel.theElements[indexPath.section - 1];
                if (!focus.more) {
                    FocusFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"focusFourTableViewCell" forIndexPath:indexPath];
                    [cell cellConfigureWithFocus:focus];
                    return cell;
                }else{
                    FocusFiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"focusFiveTableViewCell" forIndexPath:indexPath];
                    [cell cellConfigureWithFocus:focus];
                    
                    // 如果有更多的话, 需要实现cell中点解更多的代理
                    cell.delegate = self;
                    
                    
                    return cell;
                }
               
            }
            default:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] init];
                return cell;
                break;
            }
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return (self.screenWidth - 20) * 660.0 /1242 + 20;
    }
    else{
 
        CGSize cellSizeL = CGSizeMake(self.theTableView.frame.size.width - 20, (self.theTableView.frame.size.width - 20) / 380.0 * 240);
        CGSize cellSizeS = CGSizeMake((self.theTableView.frame.size.width - 30) / 2, (self.theTableView.frame.size.width - 30) / 2);
        
        NSInteger count = self.focusListModel.theElements[indexPath.section - 1].dataList.count;
        BOOL isMore = self.focusListModel.theElements[indexPath.section - 1].more;
        if (count == 1) {
            return cellSizeL.height + 10;
        }
        if (count == 2) {
            NSLog(@"%lf", 2*(cellSizeL.height + 10));
            return 2*(cellSizeL.height + 10);
        }
        if (count == 3) {
            return 2 * (cellSizeS.height + 10);
        }
        if (count == 4) {
            if (!isMore) {
                return 2 * (cellSizeS.height + 10);
            }else{
                return 2 * (cellSizeS.height + 10) + 40;
            }
        }
        return 0;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"推荐";
    }
    else{
        return self.focusListModel.theElements[section - 1].title;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
    
        BannerWebViewController *bannerWebVC = [[BannerWebViewController alloc] init];
        bannerWebVC.banners = self.focusListModel.theBanners[indexPath.row];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:bannerWebVC];
        [self presentViewController:navigation animated:YES completion:nil];
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = KLightGreen;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = KLightGreen;
}


#pragma mark ---收到focusView被点击的操作----
- (void)focusViewTap: (NSNotification *)notification{
 
    FocusPlaceDetaliViewController *focusPlaceDetailVC = [[FocusPlaceDetaliViewController alloc] init];
    focusPlaceDetailVC.nearByItem = notification.userInfo[@"nearBtItem"];

    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:focusPlaceDetailVC];

    [self presentViewController:navigation animated:YES completion:nil];

    
}


#pragma mark ----执行点击更多的代理------
- (void)touchMoreButton:(Focus *)focus{
    FocusMoreViewController *focusMoreVC = [[FocusMoreViewController alloc] init];
    focusMoreVC.focus = focus;
    focusMoreVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:focusMoreVC animated:YES];
    
}




- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
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
