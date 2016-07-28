//
//  OriginalDetailOutlineViewController.m
//  Product_B
//
//  Created by by wushuputi on 16/7/22.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalDetailOutlineViewController.h"


@interface OriginalDetailOutlineViewController ()<UIScrollViewDelegate>

@property(strong, nonatomic)UIView *theView;

@end

@implementation OriginalDetailOutlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//
    self.view.backgroundColor = [UIColor whiteColor];
    // 更改tableView的frame
    self.theTableView.backgroundColor = [UIColor whiteColor];
    self.theTableView.frame = CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height + 64);
    
    
    self.theView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
    self.theView.backgroundColor = [UIColor colorWithRed:0 green:204.0/255 blue:209.0/255 alpha:1];
    self.theView.alpha = 0;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 400, 40)];
    label.text = self.originalDetailModel.name;
    [self.theView addSubview:label];
    
    [self.view addSubview:self.theView];
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backButton.tintColor = [UIColor whiteColor];
    [backButton setImage:[UIImage imageNamed:@"arrow"] forState:(UIControlStateNormal)];
    backButton.frame =CGRectMake(0, 20, 44, 44);
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:(UIControlEventTouchUpInside)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)backAction:(UIBarButtonItem *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---重写方法----


- (void)requestData{
};


#pragma mark ---配置ui的方法---
- (void)configureTitleHeaderView:(OriginalDetailHeaderView *)header{
    [header viewConfigureWithOriginalDetailModelOutline:self.originalDetailModel];
}

- (void)configureTitleCell:(OriginalTilteTableViewCell *)cell{
    [cell cellCongifureWithOriginalDetailModel:self.originalDetailModel];
}


- (void)configureDetailCell:(OriginalDetailItemTableViewCell*)cell wayPoint:(Waypoint *)wayPoint{
    [cell cellCoinfigureWithWaypointOutline:wayPoint];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > 50) {
        self.theView.alpha = (offsetY - 50) / 130;
    }else{
         self.theView.alpha = 0;
    }
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
