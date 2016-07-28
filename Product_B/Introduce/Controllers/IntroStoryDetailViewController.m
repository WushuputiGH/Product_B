//
//  IntroStoryDetailViewController.m
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 YMN. All rights reserved.
//

#import "IntroStoryDetailViewController.h"
#import "IntroCollectDetailModel.h"
#import "IntroCollectStoryDetailCell.h"

@interface IntroStoryDetailViewController ()<UITableViewDataSource, UITableViewDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UILabel *introL;

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSMutableArray *photos; // 装载图片数组
@property (nonatomic, strong) NSMutableArray *texts; // 图片下方的文字

@property (nonatomic, strong) NSMutableArray *footArray; // 尾视图





@end

@implementation IntroStoryDetailViewController

#pragma mark -- 数据请求
- (void)requestData
{
    // 2387843168
    [YRequestManager requestWithUrlString:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/new_trip/spot?spot_id=%@",self.model.spot_id] parDic:nil requestType:RequestGET finish:^(NSData *data) {
       
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.modelArray = [IntroCollectDetailModel collectDetailModelConfigureJsonDic:dic];
        
        for (IntroCollectDetailModel *model in self.modelArray)
        {
            MWPhoto *photo;
            photo = [MWPhoto photoWithURL:[NSURL URLWithString:model.photo]];

//            model.text // 请求下来的字符串
            NSMutableString *str;
            /*
            if (model.text.length > 0)
            {
                str = [NSMutableString stringWithString:model.text];
                str = [str substringToIndex:3];
            }
            
            if (str.length > 0)
            {
                str = str;
            }else{
                str = [NSMutableString stringWithString:@""];
            }
             */
            
            
            if (model.text.length >0 && model.text.length <= 100)
            {
                str = [NSMutableString stringWithString:model.text];
            }else if (model.text.length > 180){
                
                str = [NSMutableString stringWithString:model.text];
                str = [str substringToIndex:179];
                
            }else{
                str = [NSMutableString stringWithString:@""];
            }
                        
            
            
//            photo.caption = model.text;
            photo.caption = str;
            [self.photos addObject:photo];
            [self.texts addObject:photo.caption];
            
//            [self.photos addObject:model.photo];
//            [self.texts addObject:model.text];
            
        }
        
        self.introduce = [dic valueForKeyPath:@"data.trip.user.user_desc"];
        self.introL.text = [NSString stringWithFormat:@"❀再次隆重声明❀：\n        %@\n大家快来分享自己的趣事吧😊！", self.introduce];
        
        [self.tableV reloadData];
        
    } error:^(NSError *error) {
        
    }];
}

#pragma mark 属性
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

- (NSMutableArray *)footArray
{
    if (!_footArray) {
        _footArray = [NSMutableArray array];
    }
    return _footArray;
}

- (void)initTableView
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, KScreenWidth - 10, KScreenHeight - 64) style:(UITableViewStylePlain)];
    
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.estimatedRowHeight = 100;
    
    self.tableV.tableHeaderView = self.headView;
    self.tableV.tableFooterView = self.footView;
    
    [self.view addSubview:self.tableV];
    
    [self.tableV registerClass:[IntroCollectStoryDetailCell class] forCellReuseIdentifier:@"collectDetail"];
}

- (UIView *)headView
{
    if (!_headView) {

        _headView = [[UIView alloc] init]; // 在下面自定义高度
        
    
        // 是从主界面的collect 点进来的
        if (self.isMain == YES)
        {
            UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(5, 15, 70, 70)];
            backV.backgroundColor = [UIColor grayColor];
            backV.layer.cornerRadius = 45;
            backV.layer.masksToBounds = YES;
            [self.headView addSubview:backV];
            
            UIImageView *userV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 60, 60)];
            [userV sd_setImageWithURL:[NSURL URLWithString:self.avatar_l] completed:nil];
            userV.layer.cornerRadius = 30;
            userV.layer.masksToBounds = YES;
            [self.headView addSubview:userV];
            
            UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, 120, 30)];
//            nameL.text = self.model.user[@"name"];
            nameL.text = self.naviName;
            [self.headView addSubview:nameL];
            nameL.textColor = KCOLOR(53, 85, 212);
            UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, KScreenWidth - 10, 1)];
            v1.backgroundColor = KCOLOR(100, 100, 100);
            [self.headView addSubview:v1];
            
        }
        // 从二级 collect 点进来的
        else if(self.isMain == NO)
        {
            UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(5, 15, 70, 70)];
            backV.backgroundColor = [UIColor grayColor];
            backV.layer.cornerRadius = 45;
            backV.layer.masksToBounds = YES;
            [self.headView addSubview:backV];
        
            UIImageView *userV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 60, 60)];
            [userV sd_setImageWithURL:[NSURL URLWithString:self.model.user[@"avatar_l"]] completed:nil];
            userV.layer.cornerRadius = 30;
            userV.layer.masksToBounds = YES;
            [self.headView addSubview:userV];
            
            UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, 120, 30)];
            nameL.text = self.model.user[@"name"];
            [self.headView addSubview:nameL];
            nameL.textColor = KCOLOR(53, 85, 212);
            UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, KScreenWidth - 10, 1)];
            v1.backgroundColor = KCOLOR(100, 100, 100);
            [self.headView addSubview:v1];
            
        }
        
        UILabel *introL = [[UILabel alloc] init];
        introL.text = self.model.text;
        introL.numberOfLines = 0; // text 中包含 \n ,不要忘记此步
        introL.textColor = KCOLOR(7, 94, 27);
        CGFloat h = [AutotHeight autoHeightByString:introL.text width:KScreenWidth - 15 font:15];
        introL.frame = CGRectMake(5, 100, KScreenWidth - 15, h + 30);
        
        [self.headView addSubview:introL];
        
        _headView.frame = CGRectMake(0, 0, KScreenWidth - 10, h + 30 + 100 + 20);
        
//        [self.headView setBackgroundColor: [UIColor yellowColor]];
        [self.view addSubview:self.headView];
        
    }
    return _headView;
}

- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 10, 150)];
        
        UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(0, 5, KScreenWidth - 10, 1)];
        v2.backgroundColor = KCOLOR(100, 100, 100);
        [self.footView addSubview:v2];
        
        
        [self.view addSubview:self.footView];
    }
    return _footView;
}

- (UILabel *)introL
{
    if (!_introL) {
        _introL = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, KScreenWidth - 10, 130)];
        _introL.numberOfLines = 0;
        
        [self.footView addSubview:_introL];
    }
    return _introL;
}

#pragma mark -- tableview 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntroCollectDetailModel *model = self.modelArray[indexPath.row];
    IntroCollectStoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectDetail" forIndexPath:indexPath];
    [cell cellConfigureCollectDetailModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self]; // 图片浏览器
    browser.displayActionButton = YES;
    browser.displayNavArrows = YES;
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
    
    
    [browser reloadData];




}

#pragma mark -- MWPhotoBrowser Delegate
// 返回图片的个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

// 返回 MWPhoto* 类型的图片 和 图片下方的文字
- (id )photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    if (index < self.photos.count)
    {
//        MWPhoto *photo;
//        photo = [MWPhoto photoWithURL:[NSURL URLWithString:[self.photos objectAtIndex:index]]]; // 照片
//        
//        photo.caption = self.texts[index]; // 照片下方的文字
//        return photo;
     
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

// 点击进去是多张网络缩略图（多张网络缩略图（enableGrid＝ YES）时，才可以实现该委托方法）
- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

//- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index
//{
//    return [[self.photos objectAtIndex:index] boolValue];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index
//{
//    NSString * uid=[NSString stringWithFormat:@"%@",[comicDetailDictionary objectForKey:@"id"]];
//    NSString * cid=[NSString stringWithFormat:@"%@",[comicDetailDictionary objectForKey:@"lid"]];
//    [base updatelist:uid cid:cid subStatus:index];
//}


#pragma mark -- viewDidLoad --
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = [NSString stringWithFormat:@"'%@'的故事", self.naviName];
    [[UINavigationBar appearance] setTintColor:KCOLOR(255, 255, 255)];
    self.view.backgroundColor = KCOLOR(255, 255, 255);

    [self requestData];
    [self initTableView];
    
    [self headView];
    [self footView];
    [self introL];
    
    // Do any additional setup after loading the view.
}



@end
