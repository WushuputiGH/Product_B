//
//  TripsTableViewConatroller.m
//  Product_B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 H. All rights reserved.
//

#import "TripsTableViewConatroller.h"
#import "TripListModel.h"
#import "TripsTableViewCell.h"


@interface TripsTableViewConatroller ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign)DataRequestType dataRequestType; // 数据请求的类型, 第一次请求, 下拉刷新, 上拉加载更多

@property (nonatomic, strong)TripListModel *shareTripListModel;
@property (nonatomic, strong)UITableView *theTripListTableView;


@end





@implementation TripsTableViewConatroller

- (UITableView *)theTripListTableView{
    if (!_theTripListTableView) {
        _theTripListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:(UITableViewStylePlain)];
        _theTripListTableView.dataSource = self;
        _theTripListTableView.delegate = self;
        _theTripListTableView.backgroundColor = kTableViewColor;
        [_theTripListTableView registerNib:[UINib nibWithNibName:@"TripsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tripsTableViewCell"];
        _theTripListTableView.rowHeight = UITableViewAutomaticDimension;
        _theTripListTableView.estimatedRowHeight = 200;
        _theTripListTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.dataRequestType = DataRequestTypeMore;
            [self requestData];
        }];
    }
    return _theTripListTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataRequestType = DataRequestTypeFirst;
    
    // 添加原创与点评tableView
    self.shareTripListModel = [TripListModel shareTripListModel];
    self.shareTripListModel.next_start = @0;
    [self.view addSubview:self.theTripListTableView];
    [self requestData];
    
   
}



- (void)requestData{
    
    // 用于请求trips的接口, 需要参数2388393409是指deatinationDetail的id, star是指上一次请求下来的next_start值, 第一次为0
    // http://api.breadtrip.com/v2/destination/poi/2388393409/trips/?start=0&count=5
    
    
    if (self.dataRequestType == DataRequestTypeMore && ![self.shareTripListModel.next_start isKindOfClass:[NSNumber class]]) {
        [self.theTripListTableView.mj_footer endRefreshing];
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/v2/destination/poi/%@/trips/?start=%@&count=5", self.theId, self.shareTripListModel.next_start];
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (self.dataRequestType == DataRequestTypeFirst) {
            [self.shareTripListModel setValuesForKeysWithDictionary:jsonDic];
        }
        if (self.dataRequestType == DataRequestTypeMore) {
            [self.shareTripListModel requstMoreData:jsonDic];
            [self.theTripListTableView.mj_footer endRefreshing];
        }
        
        [self.theTripListTableView reloadData];
        
    } error:^(NSError *error) {
        
    }];
    
}


#pragma mark ---实现tableView协议----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  return  self.shareTripListModel.trips.count;
  

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    TripsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tripsTableViewCell" forIndexPath:indexPath];
    [cell cellConfigureWithIndexRow:indexPath.row];
    return cell;

    
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
