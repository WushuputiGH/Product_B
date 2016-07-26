//
//  IntroTableDetailViewController.m
//  Product_B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroTableDetailViewController.h"
#import "IntroTableDetailModel.h"
#import "IntroTableDetailCell.h"


@interface IntroTableDetailViewController ()<UITableViewDataSource, UITableViewDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSMutableArray *photos; // 用于装载图片
@property (nonatomic, strong) NSMutableArray *texts; // 装载图片下方的文字


@property (nonatomic, strong) UITableView *tableV;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *mapV;
@property (nonatomic, strong) UIImageView *userV;
@property (nonatomic, strong) UIView *backV;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *lab1; // 头视图表格中的数据
@property (nonatomic, strong) UILabel *lab11;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab22;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab33;


@end

@implementation IntroTableDetailViewController

#pragma mark -- 懒加载 / 属性
- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (NSMutableArray *)texts
{
    if (!_texts) {
        _texts = [NSMutableArray array];
    }
    return _texts;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, (KScreenHeight - 64) / 2.0 + 80)];
//        _headerView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:self.headerView];
    }
    return _headerView;
}

- (UIImageView *)mapV
{
    if (!_mapV) {
        _mapV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, (KScreenHeight - 64) / 3.0 - 10)];
        [_mapV sd_setImageWithURL:[NSURL URLWithString:self.model.trackpoints_thumbnail_image] completed:nil];
        
        [self.headerView addSubview:_mapV];
    }
    return _mapV;
}

- (UIImageView *)userV
{
    if (!_userV) {
        _userV = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth / 2.0 - 40, (KScreenHeight - 64) / 4.0, 80, 80)];
        _userV.layer.cornerRadius = 40;
        _userV.layer.masksToBounds = YES;
        [_userV sd_setImageWithURL:[NSURL URLWithString:self.avatar_l] completed:nil];
        
        [self.headerView addSubview:_userV];
    }
    return _userV;
}

- (UIView *)backV
{
    if (!_backV) {
        _backV = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth / 2.0 - 45, (KScreenHeight - 64) / 4.0 - 5, 90, 90)];
        _backV.backgroundColor = [UIColor grayColor];
        _backV.layer.cornerRadius = 45;
        _backV.layer.masksToBounds = YES;
        [self.headerView addSubview:_backV];
    }
    return _backV;
}

- (UILabel *)nameL
{
    if (!_nameL) {
        _nameL = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth / 2.0 - 60, (KScreenHeight - 64) / 4.0 + 85, 120, 30)];
        _nameL.font = [UIFont systemFontOfSize:13];
        _nameL.textAlignment = YES; // 居中
        _nameL.textColor = KCOLOR(53, 85, 212);
        
        [self.headerView addSubview:_nameL];
    }
    return _nameL;
}

- (UILabel *)titleL
{
    if (!_titleL) {
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(50, (KScreenHeight - 64) / 2.0 - 50, KScreenWidth - 100, 50)];
        _titleL.text = self.navigationItem.title;
        _titleL.textAlignment = YES;
        _titleL.numberOfLines = 0;
        _titleL.shadowColor = KCOLOR(200, 200, 200);
        _titleL.shadowOffset = CGSizeMake(2, 2);
        
        [self.headerView addSubview:_titleL];
    }
    return _titleL;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, (KScreenHeight - 64) / 2.0 + 10 , KScreenWidth - 20 - 10, 60)];
        _lineView.backgroundColor = KCOLOR(250, 243, 213);
        
        UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 20 - 10, 1)];
        v1.backgroundColor = KCOLOR(180, 180, 180);
        [_lineView addSubview:v1];
        
        UIView *v2 = [[UIView alloc] init];
        v2.backgroundColor = KCOLOR(180, 180, 180);
        
        UIView *v3 = [[UIView alloc] init];
        v3.backgroundColor = KCOLOR(200, 200, 200);
        
        v2.frame = CGRectMake((KScreenWidth - 30) / 3.0, 5 , 1, 50);
        [_lineView addSubview:v2];
            
        v3.frame = CGRectMake((KScreenWidth - 30) / 3.0 * 2, 5, 1, 50);
        [_lineView addSubview:v3];
        
        UIView *v4 = [[UIView alloc] initWithFrame:CGRectMake(0, 59, KScreenWidth - 30, 1)];
        v4.backgroundColor = KCOLOR(180, 180, 180);
        [_lineView addSubview:v4];
        

        self.lab2 = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth - 30) / 3.0, 10, (KScreenWidth - 30) / 3.0, 15)];
        self.lab2.text = @"里程";
        self.lab2.textAlignment = 1;
        self.lab2.font = [UIFont systemFontOfSize:13];
        [_lineView addSubview:self.lab2];
        
     
        
        self.lab3 = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth - 30) / 3.0 * 2, 10, (KScreenWidth - 30) / 3.0, 15)];
        self.lab3.text = @"喜欢";
        self.lab3.textAlignment = 1;
        self.lab3.font = [UIFont systemFontOfSize:13];
        [_lineView addSubview:self.lab3];
        
      
        
        
        [self.headerView addSubview:_lineView];
    }
    return _lineView;
}

- (UILabel *)lab1
{
    if (!_lab1) {
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (KScreenWidth - 30) / 3.0, 15)];
        self.lab1.textAlignment = 1;
        self.lab1.font = [UIFont systemFontOfSize:13];

        [_lineView addSubview:self.lab1];
    }
    return _lab1;
}

- (UILabel *)lab11
{
    if (!_lab11) {
        _lab11 = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, (KScreenWidth - 30) / 3.0, 15)];
        self.lab11.textAlignment = 1;
        self.lab11.textColor = KCOLOR(160, 160, 160);
        self.lab11.font = [UIFont systemFontOfSize:13];
        [_lineView addSubview:self.lab11];
    }
    return _lab11;
}

- (UILabel *)lab22
{
    if (!_lab22) {
        _lab22 = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth - 30) / 3.0, 35, (KScreenWidth - 30) / 3.0, 15)];
        self.lab22.textAlignment = 1;
        self.lab22.textColor = KCOLOR(160, 160, 160);
        self.lab22.font = [UIFont systemFontOfSize:13];
        [_lineView addSubview:self.lab22];
    }
    return _lab22;
}

- (UILabel *)lab33
{
    if (!_lab33) {
        _lab33 = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth - 30) / 3.0 * 2, 35, (KScreenWidth - 30) / 3.0, 15)];
        self.lab33.textAlignment = 1;
        self.lab33.textColor = KCOLOR(160, 160, 160);
        self.lab33.font = [UIFont systemFontOfSize:13];
        [_lineView addSubview:self.lab33];
    }
    return _lab33;
}

#pragma mark -- viewDidLoad --
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KCOLOR(255, 255, 255);

    [self requestData];
    [self initTableView];
    
    
    // 不能在viewDidLoad 中添加，如：***[self.view addSubview:self.headerView]; **** [self.headerView addSubview:self.nameL]; 否则不能滑动。
    [self headerView];
    [self mapV];
    [self backV];
    [self userV];
    [self nameL];
    [self titleL];
    [self lineView];
    [self lab1];
    [self lab11];
    [self lab22];
    [self lab33];
    
    // Do any additional setup after loading the view.
}


#pragma mark -- 数据请求
- (void)requestData
{
    
    [YRequestManager requestWithUrlString:[NSString stringWithFormat:@"http://api.breadtrip.com/trips/%ld/waypoints/", self.model.trip_id] parDic:nil requestType:RequestGET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.modelArray = [IntroTableDetailModel tableDetailModelConfigureJsonDic:dic];
        for (IntroTableDetailModel *model in self.modelArray)
        {
            [self.photos addObject:model.photo];
//            [self.texts addObject:model.text];
            
            NSMutableString *str;
            
            if (model.text.length >0 && model.text.length <= 180)
            {
                str = [NSMutableString stringWithString:model.text];
                
            }else if (model.text.length > 180){
                
                str = [NSMutableString stringWithString:model.text];
                str = [str substringToIndex:179];
                
            }else{
                
                str = [NSMutableString stringWithString:@""];
            }
            
            [self.texts addObject:str];
            
        }
        
        self.trackpoints_thumbnail_image = [dic valueForKeyPath:@"trackpoints_thumbnail_image"];
        [self.mapV sd_setImageWithURL:[NSURL URLWithString:self.trackpoints_thumbnail_image] completed:nil];
        
        self.auth = [dic valueForKeyPath:@"user.name"];
        self.nameL.text = [NSString stringWithFormat:@"by %@", self.auth];
        
        self.lab1.text = [dic valueForKeyPath:@"first_day"];
        self.lab11.text = [NSString stringWithFormat:@"%d天",[[dic valueForKeyPath:@"day_count"] intValue]];
        self.lab22.text = [NSString stringWithFormat:@"%.2fkm",[[dic valueForKeyPath:@"mileage"] floatValue]];
        self.lab33.text = [NSString stringWithFormat:@"%d", [[dic valueForKeyPath:@"recommendations"] intValue]];
        
        
        [self.tableV reloadData];
        
    } error:^(NSError *error) {
        
    }];
}

#pragma mark -- tableView 和 dataSource 方法
- (void)initTableView
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, KScreenWidth - 10, KScreenHeight - 64) style:(UITableViewStylePlain)];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    
    self.tableV.estimatedRowHeight = 100;
    self.tableV.tableHeaderView = self.headerView;
    
    [self.view addSubview:self.tableV];
    
    [self.tableV registerClass:[IntroTableDetailCell class] forCellReuseIdentifier:@"tableDetail"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntroTableDetailModel *model = self.modelArray[indexPath.row];
    
    IntroTableDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableDetail" forIndexPath:indexPath];
    
    [cell cellConfigureTableDetailModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self]; // 图片浏览器
    browser.displayActionButton = YES;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = YES;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = YES;
    browser.startOnGrid = YES;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = NO;
  
    // Optionally set the current visible photo before displaying
    //[browser setCurrentPhotoIndex:1]; // 显示第一张
    [browser setCurrentPhotoIndex:indexPath.row]; // 显示当前点击的图片
    
    [self.navigationController pushViewController:browser animated:YES];
    
    // Manipulate
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    //[browser setCurrentPhotoIndex:1];
    [browser setCurrentPhotoIndex:indexPath.row];
    
    
    [browser reloadData];}


#pragma mark - MWPhotoBrowserDelegate

// 返回图片的个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

// 返回 MWPhoto* 类型的图片 和 图片下方的文字
- (id )photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
    {
        MWPhoto *photo;
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:[self.photos objectAtIndex:index]]]; // 照片
        
        photo.caption = self.texts[index]; // 照片下方的文字
        
        return photo;
    }
    return nil;
}

// 点击进去是多张网络缩略图（多张网络缩略图（enableGrid＝ YES）时，才可以实现该委托方法）
- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count) {
        MWPhoto *photo;
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:[self.photos objectAtIndex:index]]];
        return photo;
    }
    return nil;
}



@end
