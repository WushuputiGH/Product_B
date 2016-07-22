//
//  OriginalItemListViewController.m
//  Product_B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalItemListViewController.h"
#import "OriginalItemList.h"
#import "OriginalTableViewCell.h"
#import "OriginalDetailViewController.h"


@interface OriginalItemListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *theTabelView;
@property (nonatomic, strong)OriginalItemList *originalItemList;
@property (nonatomic, assign)BOOL isMore;

@property (nonatomic, assign)NSInteger screenWidth;
@property (nonatomic, assign)NSInteger screenHeight;
@end

@implementation OriginalItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isMore = NO;
    
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.originalItemList = [[OriginalItemList alloc] init];
    
    
    [self.view addSubview:self.theTabelView];
    
    self.theTabelView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.isMore = YES;
        [self requestData];
        
    }];
    
    [self requestData];
    
}

- (UITableView *)theTabelView{
    if (!_theTabelView) {
        _theTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _screenWidth, _screenHeight) style:(UITableViewStylePlain)];
        _theTabelView.dataSource = self;
        _theTabelView.delegate = self;
        [_theTabelView registerNib:[UINib nibWithNibName:@"OriginalTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"originalTableViewCell"];
        
        _theTabelView.rowHeight = 200; 
    }
    return _theTabelView;
}



- (void)requestData{
    // http://api.breadtrip.com/v2/destination/place/3/13961/trips/?start=20
    
    NSString *urlString = nil;
    if (!self.isMore) {
        urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/v2/destination/place/%@/%@/trips/", self.theType, self.theId];
    }else{
        urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/v2/destination/place/%@/%@/trips/?start=%@", self.theType, self.theId, self.originalItemList.next_start];
    }
    

    
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
        if (self.isMore) {
            [self.originalItemList getMoreDataWithJsonDic:jsonDic];
        }else{
            [self.originalItemList setValuesForKeysWithDictionary:jsonDic];
        }
        
        [self.theTabelView reloadData];
    } error:^(NSError *error) {
        
    }];
    
    self.isMore = NO;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.originalItemList.originalItemList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OriginalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"originalTableViewCell" forIndexPath:indexPath];
    OriginalItem *originalItem = self.originalItemList.originalItemList[indexPath.row];
    [cell cellConfigureWithOriginalItem:originalItem];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OriginalDetailViewController *originalDetailVC = [[OriginalDetailViewController alloc] init];
    originalDetailVC.thePlaceId = self.theId;
    originalDetailVC.theplaceType = self.theType;
    OriginalItem *originalItem = self.originalItemList.originalItemList[indexPath.row];
    originalDetailVC.theOriginalItemId = originalItem.originalItemId;
    
    originalDetailVC.originalItem = originalItem;
    
    // 将cell转成image传递给originalDetailVC
    originalDetailVC.downImage = [self imageWithUIView:[tableView cellForRowAtIndexPath:indexPath]];
    [self.navigationController pushViewController:originalDetailVC animated:YES];
}



#pragma mark ---将view转成image----
- (UIImage *)imageWithUIView:(UIView*)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
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
