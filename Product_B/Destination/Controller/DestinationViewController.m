//
//  DestinationViewController.m
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import "DestinationViewController.h"
#import "DeatinationDetailModel.h"
#import "IntroduceTableViewCell.h"
#import "DeatinationHeaderView.h"
#import "ImpressionsTableViewCell.h"
#import "ImpressionsHeaderView.h"
#import "ImpressionsWithoutImageTableViewCell.h"
#import "InformationTableViewCell.h"
#import "TripsViewController.h"

#import <objc/runtime.h>

#define HeadImgHeight ([UIScreen mainScreen].bounds.size.width * 24.0 / 38)
#define Width [UIScreen mainScreen].bounds.size.width

@interface DestinationViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)DeatinationDetailModel *shareDeatinationDetailModel;
@property(nonatomic, strong)UITableView *theTableView;
@property(nonatomic, strong)DeatinationHeaderView *headerView;

@end

@implementation DestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    // Do any additional setup after loading the view.
    self.shareDeatinationDetailModel = [DeatinationDetailModel shareModel];
    // 使用runtime, 首先将nearItem的值赋值给shareDeatinationDetailModel
    // 首先获取nearByItem的所有属性名字
#warning 模型转成字典:
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([NearByItem class], &count);
    
    for (int i =  0; i < count; i ++) {
        objc_property_t property = properties[i];
        const void *propertyName = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:propertyName];
        [self.shareDeatinationDetailModel setValue:[self.nearByItem valueForKey:key] forKey:key];
    }
    free(properties);
  
    
    [self requestData];
    self.theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:(UITableViewStyleGrouped)];
    self.theTableView.dataSource = self;
    self.theTableView.delegate = self;
    self.theTableView.estimatedRowHeight = 200;
    self.theTableView.separatorStyle = 0;
    
    self.theTableView.backgroundColor = kTableViewColor;
    
    
    
    // 注册cell
    [self.theTableView registerNib:[UINib nibWithNibName:@"IntroduceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"introduceCell"];
    
    [self.theTableView registerNib:[UINib nibWithNibName:@"ImpressionsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ImpressionsTableViewCell"];
    
    [self.theTableView registerNib:[UINib nibWithNibName:@"ImpressionsWithoutImageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"impressionsWithoutImageTableViewCell"];
     [self.theTableView registerNib:[UINib nibWithNibName:@"InformationTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"informationTableViewCell"];

    [self.view addSubview:self.theTableView];
    
    
    // 添加假的header
    CGRect frame = CGRectMake(0, 0, Width, HeadImgHeight);
    self.headerView = [[DeatinationHeaderView alloc] initWithFrame:frame];
    [self.theTableView addSubview:self.headerView];
    
    
}


// 网络请求
- (void)requestData{
    // 数据请求接口, 其中5代表的是传进来的type,2388393409代表id
//    http://api.breadtrip.com/destination/place/5/2388393409/
    
    

    
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/", self.nearByItem.type, self.nearByItem.nearByItemId];
    NSLog(@"%@", urlString);
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        [self.shareDeatinationDetailModel setValuesForKeysWithDictionary:jsonDic];
        if (self.shareDeatinationDetailModel.cover_route_map_cover && ![self.shareDeatinationDetailModel.cover_route_map_cover isEqual: @""]) {
             [self.headerView.theStretchImage sd_setImageWithURL:[NSURL URLWithString:self.shareDeatinationDetailModel.cover_route_map_cover]];
        }else{
            
            NSArray *hottestPlaces = self.shareDeatinationDetailModel.hottestPlaces;
            if (hottestPlaces == nil || hottestPlaces.count == 0) {
                self.headerView.theStretchImage.image = kPlaceHolderImage2;
            }else{
                HottestPlace *hottestPlace = hottestPlaces[0];
                [self.headerView.theStretchImage sd_setImageWithURL:[NSURL URLWithString:hottestPlace.photo] placeholderImage:[UIImage imageNamed:@"placeHolder1.jpg"]];
            }
           
        }
       
        [self.theTableView reloadData];
        
    } error:^(NSError *error) {
        
    }];
    
    
}

#pragma mark ---实现table协议----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
        {
            NSArray *reviews = self.shareDeatinationDetailModel.theImpressions[@"reviews"];
            NSArray *trips = self.shareDeatinationDetailModel.theImpressions[@"trips"];
            return reviews.count + trips.count;
            break;
        }
        case 2:
            return 6;
            break;
        default:
            return 0;
            break;
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            IntroduceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"introduceCell" forIndexPath:indexPath];
            [cell cellConfigure];
         
            
            return cell;
            break;
        }
            
        case 1:
        {
            NSArray *trips = self.shareDeatinationDetailModel.theImpressions[@"trips"];
            if (indexPath.row >= trips.count) {
                // 当是第三行的时候, 显示的是评论
                ImpressionsWithoutImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"impressionsWithoutImageTableViewCell" forIndexPath:indexPath];
                [cell cellConfigureWithRow:indexPath.row - trips.count];
                return cell;
                
            }else{
                // 当是第一行与第二行的时候
                ImpressionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImpressionsTableViewCell" forIndexPath:indexPath];
                [cell cellConfigureWithIndexRow:indexPath.row];
                return cell;
            }
        }
        case 2:{
            InformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"informationTableViewCell" forIndexPath:indexPath];
            [cell cellConfigureWithRow:indexPath.row];
            return cell;
            
            break;
        }
        default:
            return [[UITableViewCell alloc] init];
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    switch (section) {
        case 0:
        {
            CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.width * (24.0 / 38) + 15));
//            self.headerView = [[DeatinationHeaderView alloc] initWithFrame:frame];
            UIView *view = [[UIView alloc] initWithFrame:frame];
            return view;
            break;
        }
        default:
        {
            ImpressionsHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"ImpressionsHeaderView" owner:nil options:nil] firstObject];
            headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
            if (section == 1) {
                headerView.titleLabel.text = @"行走印象";
            }
            if (section == 2) {
                headerView.titleLabel.text = @"基本信息";
            }
            
            headerView.backgroundColor = kTableViewColor;
            return headerView;
        }
            break;
    }
   
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [button setTitle:@"更多印象" forState:(UIControlStateNormal)];
        button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 75, 20, 150, 40);
        button.layer.cornerRadius = 20;
        button.clipsToBounds = YES;
        button.layer.borderWidth = 2;
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        UIColor *color = [UIColor colorWithRed:52.0 / 255 green:153.0 /255 blue:153.0 /255 alpha:1];// 51, 153, 153
        button.tintColor = color;
        button.layer.borderColor = color.CGColor;
        [button addTarget:self action:@selector(moreImpressions) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
        return view;
    }else{
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return HeadImgHeight;
            break;
        default:
            return 50;
            break;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 70;
    }else{
        return 0.1;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2 && indexPath.row == 5) {
      
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否拨打电话" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *telAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
            // 获取cell
            InformationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            // 获取电话号码
            // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://8008808888"]];
            NSString *tel = [NSString stringWithFormat:@"tel://%@",cell.contentLabel.text];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: tel]];
        }];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alertController addAction:telAction];
        [alertController addAction:cancleAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
        
    }

}


#pragma mark--- 当下拉的时候, 图片放大----

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) {
        self.headerView.frame = CGRectMake(offsetY/2, offsetY, Width - offsetY, HeadImgHeight - offsetY);  // 修改头部的frame值就行了
    }
}


#pragma mark ---点击更多印象按钮, 执行的方法---
- (void)moreImpressions{
    
    // 建立原创与点评视图
    TripsViewController *tripsVC = [[TripsViewController alloc] init];
    tripsVC.theId = self.shareDeatinationDetailModel.nearByItemId.description;
    tripsVC.type = self.shareDeatinationDetailModel.type;
    [self.navigationController pushViewController:tripsVC animated:YES];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
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
