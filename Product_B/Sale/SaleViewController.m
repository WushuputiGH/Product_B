//
//  ViewController.m
//  0000000
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanoukeji. All rights reserved.
//

#import "SaleViewController.h"
#import "RequestManager.h"
#import "Preduct.h"
#import "MyTableViewCell.h"
#import "DetailViewController.h"

@interface SaleViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSString *c_city;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITableView *smalltableview;
@property (nonatomic,assign)BOOL is_fond;
@property (nonatomic,strong)UIBarButtonItem *item;
@property (nonatomic,strong)NSArray *cityArray;

@end

@implementation SaleViewController  


- (void)reloadDate{
    NSLog(@"fff");
    [self reloadgateagain];
    NSString *string = [NSString stringWithFormat:@"http://api.breadtrip.com/hunter/products/more/?city_name=%@&start=0",self.c_city];
    
    self.dataArray = [NSMutableArray array];

    [YRequestManager requestWithUrlString:string parDic:nil requestType:RequestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [dic valueForKey:@"product_list"];
        for (NSDictionary *dic1 in array) {
            Preduct *pruduct = [[Preduct alloc]init];
            [pruduct setValuesForKeysWithDictionary:dic1];
            
            NSDictionary *d = [dic1 valueForKey:@"user"];
            [pruduct setValuesForKeysWithDictionary:d];
            [self.dataArray addObject:pruduct];
        }
        
        
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view insertSubview:self.tableView belowSubview:self.smalltableview];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
        });
       
        
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)loadmoreData{
    
    NSString *string = [NSString stringWithFormat:@"http://api.breadtrip.com/hunter/products/more/?city_name=%@&start=%ld",self.c_city,self.dataArray.count];
    
    [YRequestManager requestWithUrlString:string parDic:nil requestType:RequestGET finish:^(NSData *data) {
        NSString *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSArray *array = [dic valueForKey:@"product_list"];
        for (NSDictionary *dic1 in array) {
            Preduct *pruduct = [[Preduct alloc]init];
            [pruduct setValuesForKeysWithDictionary:dic1];
            NSDictionary *d = [dic1 valueForKey:@"user"];
            [pruduct setValuesForKeysWithDictionary:d];
            [self.dataArray addObject:pruduct];
        }
        [self.tableView.mj_footer endRefreshing];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)creatTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 300;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cityArray =[NSArray arrayWithObjects:@"北京",@"上海",@"深圳",@"巴黎",@"东京",@"广州",@"赫尔辛格",@"天津",@"武汉",@"香港",@"悉尼", nil];
    self.navigationItem.title = @"特价~";
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    self.item = [[UIBarButtonItem alloc] initWithTitle:@"北京" style:(UIBarButtonItemStylePlain) target:self action:@selector(click)];
    [self.navigationItem setLeftBarButtonItem:_item];
    [self creatTableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self reloadDate];

    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self loadmoreData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    [self creatSmallTableview];
    

}

- (void)creatSmallTableview{
    self.smalltableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, 100, 0) style:(UITableViewStylePlain)];
    self.smalltableview.delegate = self;
    self.smalltableview.dataSource = self;
    self.smalltableview.rowHeight = 30;
    self.smalltableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.smalltableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"class"];
    [self.view addSubview:self.smalltableview];
    
}
- (void)click{
    if (self.is_fond == NO) {
    self.smalltableview.frame = CGRectMake(0, 70, 100, 300);
        self.is_fond = YES;
    }else{
        self.smalltableview.frame = CGRectMake(0, 70, 100, 0);
        self.is_fond = NO;
    }
    
}
- (void)reloadgateagain{
    if ([self.item.title isEqualToString:@"北京"]) {
        self.c_city = @"%E5%8C%97%E4%BA%AC";
    }else if ([self.item.title isEqualToString:@"上海"]){
        self.c_city = @"%E4%B8%8A%E6%B5%B7";
    }else if ([self.item.title isEqualToString:@"巴黎"]){
        self.c_city = @"%E5%B7%B4%E9%BB%8E";
    }else if ([self.item.title isEqualToString:@"东京"]){
        self.c_city = @"%E4%B8%9C%E4%BA%AC";
    }else if ([self.item.title isEqualToString:@"赫尔辛基"]){
        self.c_city = @"%E8%B5%AB%E5%B0%94%E8%BE%9B%E5%9F%BA";
    }else if ([self.item.title isEqualToString:@"深圳"]){
        self.c_city = @"%E6%B7%B1%E5%9C%B3";
    }else if ([self.item.title isEqualToString:@"武汉"]){
        self.c_city = @"%E6%AD%A6%E6%B1%89";
    }else if ([self.item.title isEqualToString:@"香港"]){
        self.c_city = @"%E9%A6%99%E6%B8%AF";
    }else if ([self.item.title isEqualToString:@"悉尼"]){
        self.c_city = @"%E6%82%89%E5%B0%BC";
    }else if ([self.item.title isEqualToString:@"广州"]){
        self.c_city = @"E5%B9%BF%E5%B7%9E";
    }else if ([self.item.title isEqualToString:@"天津"]){
        self.c_city = @"%E5%A4%A9%E6%B4%A5";
    }
}
#pragma mark    TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableView]) {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        Preduct *model = self.dataArray[indexPath.row];
    [cell copydata:model];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"class" forIndexPath:indexPath];
        
        cell.textLabel.text = self.cityArray[indexPath.row];
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableView]) {
        
        DetailViewController *DC = [[DetailViewController alloc]init];
        Preduct *model = self.dataArray[indexPath.row];
        DC.product = model.product_id;
        
        DC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:DC animated:YES];
        
        
        
    }else if([tableView isEqual:self.smalltableview]){
        self.item.title = self.cityArray[indexPath.row];
        [self.tableView.mj_footer endRefreshing];
//        [self.dataArray removeAllObjects];
        [self.tableView.mj_header beginRefreshing];
        [self.tableView removeFromSuperview];
        self.smalltableview.frame = CGRectMake(0, 70, 100, 0);
        self.is_fond = NO;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableView]) {
        return self.dataArray.count;
    }else{
        return self.cityArray.count;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
