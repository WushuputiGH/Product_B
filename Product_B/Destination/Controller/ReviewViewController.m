//
//  ReviewViewController.m
//  Product_B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 H. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()<UITableViewDataSource, UITableViewDelegate>


typedef NS_ENUM(NSInteger, DataRequestType) {
    DataRequestTypeFirst,
    DataRequestTypeNew,
    DataRequestTypeMore
};



@property (nonatomic, assign)DataRequestType dataRequestType; // 数据请求的类型, 第一次请求, 下拉刷新, 上拉加载更多

@property (nonatomic, strong)ReviewListModel *shareReviewListModel;
@property (nonatomic, strong)UITableView *theReviewListTableView;

@end

@implementation ReviewViewController


- (UITableView *)theReviewListTableView{
    if (!_theReviewListTableView) {
        _theReviewListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:(UITableViewStylePlain)];
        _theReviewListTableView.dataSource = self;
        _theReviewListTableView.delegate = self;
        _theReviewListTableView.backgroundColor = kTableViewColor;
        [_theReviewListTableView registerNib:[UINib nibWithNibName:@"ReviewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"reviewTableViewCell"];
        _theReviewListTableView.rowHeight = UITableViewAutomaticDimension;
        _theReviewListTableView.estimatedRowHeight = 200;
        _theReviewListTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.dataRequestType = DataRequestTypeMore;
            [self requestData];
        }];
    }
    return _theReviewListTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataRequestType = DataRequestTypeFirst;
    
    // 添加原创与点评tableView
    self.shareReviewListModel = [ReviewListModel shareReviewList];
    self.shareReviewListModel.next_start = @0;
    [self.view addSubview:self.theReviewListTableView];
    [self requestData];
}


- (void)requestData{
    
    // 用于请求trips的接口, 需要参数2388393409是指deatinationDetail的id, star是指上一次请求下来的next_start值, 第一次为0
    // http://api.breadtrip.com/destination/place/5/2388393409/tips/?start=0&tip_id=
    
    
    if (self.dataRequestType == DataRequestTypeMore && ![self.shareReviewListModel.next_start isKindOfClass:[NSNumber class]]) {
        [self.theReviewListTableView.mj_footer endRefreshing];
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/tips/?start=%@&tip_id=",self.type, self.theId, self.shareReviewListModel.next_start];
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        if (self.dataRequestType == DataRequestTypeFirst) {
            [self.shareReviewListModel setValuesForKeysWithDictionary:jsonDic];
        }
        if (self.dataRequestType == DataRequestTypeMore) {
            [self.shareReviewListModel requestMoreData:jsonDic];
            [self.theReviewListTableView.mj_footer endRefreshing];
        }
        
        [self.theReviewListTableView reloadData];
        
    } error:^(NSError *error) {
        
    }];
    
}


#pragma mark ---实现tableView协议----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.shareReviewListModel.reviewList.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reviewTableViewCell" forIndexPath:indexPath];
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
