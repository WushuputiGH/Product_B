//
//  FocusPlaceDetaliViewController.m
//  Product_B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusPlaceDetaliViewController.h"
#import "FocusViewModel.h"
#import "FocusTitleHeader.h"
#import "ButtonCollectionViewCell.h"
#import "FocusCollectionViewCell.h"
#import "FocusWebViewController.h"
#import "NearByViewController.h"
#import "OriginalItemListViewController.h"
#import "DestinationViewController.h"
#import <WebKit/WebKit.h>

#define kButtonCellSpacing 10

@interface FocusPlaceDetaliViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIWebViewDelegate>

@property (nonatomic, strong)FocusViewModel *focusViewModel;

@property (nonatomic, strong)UICollectionView *theCollectionView;


// 标题头视图
@property (nonatomic, strong)UIImageView *theTitleImage;



@end



@implementation FocusPlaceDetaliViewController




- (UIImageView *)theTitleImage{
    if (!_theTitleImage) {
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
        _theTitleImage = [[UIImageView alloc] initWithFrame: frame];
//        _theTitleImage.contentMode = UIViewContentModeCenter;
        _theTitleImage.contentMode = UIViewContentModeScaleAspectFill;
        _theTitleImage.clipsToBounds = YES;
    }
    return _theTitleImage;
}

- (UICollectionView *)theCollectionView{
    if (!_theCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.itemSize = CGSizeMake(100, 100);
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        _theCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _theCollectionView.dataSource = self;
        _theCollectionView.delegate = self;
        
        _theCollectionView.backgroundColor = [UIColor clearColor];
        
        // 注册cell
        [_theCollectionView registerNib:[UINib nibWithNibName:@"ButtonCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"buttonCollectionViewCell"];
        [_theCollectionView registerNib:[UINib nibWithNibName:@"FocusCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"focusCollectionViewCell"];
        
    
        
        [_theCollectionView registerNib:[UINib nibWithNibName:@"FocusTitleHeader" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"focusTitleHeader"];
        
        // 在数据不够一屏的时候也可以滑动
        _theCollectionView.alwaysBounceVertical = YES;
    }
    return _theCollectionView;
}



- (FocusViewModel *)focusViewModel{
    if (!_focusViewModel) {
        _focusViewModel = [[FocusViewModel alloc] init];
    }
    return _focusViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemReply) target:self action:@selector(dismiss:)];
    
    [self.view addSubview:self.theTitleImage];
    [self.view addSubview:self.theCollectionView];
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [backButton setImage:[UIImage imageNamed:@"arrow"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(dismiss:) forControlEvents:(UIControlEventTouchUpInside)];
    backButton.frame = CGRectMake(0, 10, 60, 60);
    backButton.tintColor = [UIColor whiteColor];
    [self.view addSubview:backButton];

    [self requestData];
}


- (void)requestData{
    //http://api.breadtrip.com/destination/place/3/9990/
    
    NSString *url = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/", self.nearByItem.type, self.nearByItem.nearByItemId];
    [RequestManager requestManager:url finish:^(NSData *data) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        [self.focusViewModel setValuesForKeysWithDictionary:jsonDic];
        
        [self.theTitleImage sd_setImageWithURL:[NSURL URLWithString:self.focusViewModel.hottest_places[0][@"photo"]]];

        [self.theCollectionView reloadData];
        
    } error:^(NSError *error) {
        
    }];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


#pragma mark ---collectionView的代理方法----

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.focusViewModel.buttonIcon.count;
    }
    if (section == 1) {
        return self.focusViewModel.hottestSites.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"buttonCollectionViewCell" forIndexPath:indexPath];
        cell.theLabel.text = self.focusViewModel.buttonTitle[indexPath.row];
        cell.theImageView.image = [UIImage imageNamed:self.focusViewModel.buttonIcon[indexPath.row]];
        return cell;
    }else{
        FocusCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"focusCollectionViewCell" forIndexPath:indexPath];
        
        HottestSite *hottestsite = self.focusViewModel.hottestSites[indexPath.row];
        [cell.theImageView sd_setImageWithURL:[NSURL URLWithString:hottestsite.cover_s]];
        cell.name.text = hottestsite.name;
        if (hottestsite.tips_count == nil) {
            cell.starViewHeight.constant = 0;
            cell.commentLabel.text = [NSString stringWithFormat:@""];
        }else{
            cell.starViewHeight.constant = 13;
             cell.commentLabel.text = [NSString stringWithFormat:@"%@ 点评", hottestsite.tips_count];
        }
       
        cell.starRatingView.value = hottestsite.rating.floatValue;
        //
        [cell.contentView sendSubviewToBack:cell.theImageView];
        
        return cell;
    }
    

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat width = (self.theCollectionView.frame.size.width - 50) / 4;
        return CGSizeMake(width, width);
    }else{
        CGFloat width = (self.theCollectionView.frame.size.width - 30) / 2;
        return CGSizeMake(width, width);
    }
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //
    if (indexPath.section == 0) {
        FocusTitleHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"focusTitleHeader" forIndexPath:indexPath];
        header.nameLabel.text = self.focusViewModel.name;
        header.vistorAndLikerLabel.text = [NSString stringWithFormat:@"%@ 去过 / %@ 喜欢", self.focusViewModel.visited_count, self.focusViewModel.wish_to_go_count];
        return header;
        
    }else{
         FocusTitleHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"focusTitleHeader" forIndexPath:indexPath];
        header.nameLabel.text = self.focusViewModel.name;
        header.vistorAndLikerLabel.text = [NSString stringWithFormat:@"%@ 去过 / %@ 喜欢", self.focusViewModel.visited_count, self.focusViewModel.wish_to_go_count];
        return header;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(self.theCollectionView.frame.size.width, 200);
    }
    else {
        return  CGSizeZero;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        // 首先获取type
        NSNumber *type = self.focusViewModel.tools[indexPath.row][@"type"];
        if (type.integerValue == 7 || type.integerValue == 4 || type.integerValue == 1 || type.integerValue == 6) {
            FocusWebViewController *webViewController = [[FocusWebViewController alloc] init];
            webViewController.url = self.focusViewModel.tools[indexPath.row][@"url"];
            [self.navigationController pushViewController:webViewController animated:YES];
        }
        
        if (type.integerValue == 2) {
            // 跳转到旅行地点
            NearByViewController *nearByViewController = [[NearByViewController alloc] init];
            nearByViewController.theId = self.focusViewModel.focusViewId;
            nearByViewController.theType = self.focusViewModel.type;
            nearByViewController.sortType = SortTypeDefault;
            nearByViewController.isNotHaveTabBar = YES;
            [self.navigationController pushViewController:nearByViewController animated:YES];
        }
        
        if (type.integerValue == 3) {
            // 跳到精彩原创
            OriginalItemListViewController *originalVC = [[OriginalItemListViewController alloc] init];
            originalVC.theId = self.focusViewModel.focusViewId;
            originalVC.theType = self.focusViewModel.type;
            [self.navigationController pushViewController:originalVC animated:YES];
        }
    }
    
    if (indexPath.section == 1) {
        DestinationViewController *destinationVC = [[DestinationViewController alloc] init];
        NearByItem *nearByItem = [[NearByItem alloc] init];
        HottestSite *hottestsite = self.focusViewModel.hottestSites[indexPath.row];
        nearByItem.nearByItemId = hottestsite.hottestSiteId;
        nearByItem.type = hottestsite.type;
        destinationVC.nearByItem = nearByItem;
        [self.navigationController pushViewController:destinationVC animated:YES];

    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 首先获取偏移Y
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) {
        //更改titleImage的frame
        CGRect frame = CGRectMake(0, 0, self.theTitleImage.frame.size.width, 200 - offsetY);
        self.theTitleImage.frame = frame;
    }else{
        
        CGRect frame = CGRectMake(0, - offsetY, self.theTitleImage.frame.size.width, 200);
        self.theTitleImage.frame = frame;
    
    }
}



#pragma mark ---dismisss----
- (void)dismiss:(UIBarButtonItem *)button{

    [self dismissViewControllerAnimated:YES completion:nil];

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
