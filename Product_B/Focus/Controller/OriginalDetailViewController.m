//
//  OriginalDetailViewController.m
//  Product_B
//
//  Created by by wushuputi on 16/7/19.
//  Copyright © 2016年 H. All rights reserved.
//

#import "OriginalDetailViewController.h"


@interface OriginalDetailViewController ()<UITableViewDataSource, UITableViewDelegate>




@end

@implementation OriginalDetailViewController


- (OriginalDetailModel *)originalDetailModel{
    if (!_originalDetailModel) {
        _originalDetailModel = [[OriginalDetailModel alloc] init];
    }
    return _originalDetailModel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.theTableView];
    [self requestData];
}


#pragma mark ---视图显示的时候, 添加下载按钮---

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"download"] style:(UIBarButtonItemStylePlain) target:self action:@selector(save:)];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationItem.rightBarButtonItem = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --- save保存下载 -----
- (void)save:(UIBarButtonItem *)button{
    
    [self alert];
}


- (void)alert{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否下载" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"Done" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        // 如果是下载
        // 首先开始下载任务
        OriginalOutLine *originalOutline = [[OriginalOutLine alloc] init];
        originalOutline.originalItem = self.originalItem;
        originalOutline.originalDetailModel = self.originalDetailModel;
        [originalOutline archiver];
        
        // 将self.downImage传递
        NSString *key = [NSString stringWithFormat:@"OriginalOutline%@", self.originalItem.originalItemId];
        [[OriginalOutLineId defaultOriginalOutlineIdArray] addDownloadOriginalOutLine:@{key: self.downImage}];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:done];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (UITableView *)theTableView{
    if (!_theTableView) {
        _theTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        [self configureTableView];
    }
    return _theTableView;
}

- (void)configureTableView{
    _theTableView.dataSource = self;
    _theTableView.delegate = self;
    
    [_theTableView registerNib:[UINib nibWithNibName:@"OriginalTilteTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"originalTilteTableViewCell"];
    [_theTableView registerNib:[UINib nibWithNibName:@"OriginalDetailItemTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"originalDetailItemTableViewCell"];
    
    _theTableView.estimatedRowHeight = 200;
}

- (void)requestData{
    
    // http://api.breadtrip.com/trips/2387703986/waypoints/?target_type=1&target_id=US&sign=f88b574fa3506f18f1eb3356dbd46d0b
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/trips/%@/waypoints/?target_type=%@&target_id=%@", self.theOriginalItemId, self.theplaceType, self.thePlaceId];
    
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        [self.originalDetailModel setValuesForKeysWithDictionary:jsonDic];
        
        [self.theTableView reloadData];
        
        
    } error:^(NSError *error) {
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.originalDetailModel.days.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return self.originalDetailModel.days[section - 1].waypoints.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
         OriginalTilteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"originalTilteTableViewCell" forIndexPath:indexPath];
        [self configureTitleCell:cell];
        return cell;
    }else{
        
        OriginalDetailItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"originalDetailItemTableViewCell" forIndexPath:indexPath];
        Waypoint *wayPoint = self.originalDetailModel.days[indexPath.section - 1].waypoints[indexPath.row];
        [self configureDetailCell:cell wayPoint:wayPoint];
        return cell;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section == 0) {
        OriginalDetailHeaderView *header = [[[NSBundle mainBundle] loadNibNamed:@"OriginalDetailHeaderView" owner:nil options:nil] firstObject];
        header.frame = CGRectMake(0, 0, self.theTableView.frame.size.width, 348);
        [self configureTitleHeaderView:header];
        return header;
        
    }else{
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.theTableView.frame.size.width, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.theTableView.frame.size.width - 20, 30)];
        [view addSubview:label];
        
        Day *day = self.originalDetailModel.days[section - 1];
        label.text = [NSString stringWithFormat:@"第%@天 %@", day.day, day.date];
        return view;
    }
    
    
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 350;
    }else{
        return 30;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


#pragma mark ---配置ui的方法---
- (void)configureTitleHeaderView:(OriginalDetailHeaderView *)header{
    [header viewConfigureWithOriginalDetailModel:self.originalDetailModel];
}

- (void)configureTitleCell:(OriginalTilteTableViewCell *)cell{
    [cell cellCongifureWithOriginalDetailModel:self.originalDetailModel];
}


- (void)configureDetailCell:(OriginalDetailItemTableViewCell*)cell wayPoint:(Waypoint *)wayPoint{
     [cell cellCoinfigureWithWaypoint:wayPoint];
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
