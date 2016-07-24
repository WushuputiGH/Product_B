//
//  FocusMoreViewController.m
//  Product_B
//
//  Created by lanou on 16/7/23.
//  Copyright © 2016年 H. All rights reserved.
//

#import "FocusMoreViewController.h"
#import "FocusPlaceDetaliViewController.h"
#import "FocusMoreCollectionViewCell.h"


@interface FocusMoreViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *theCollectionView;


@end

@implementation FocusMoreViewController



-(Focus *)focus{
    if (!_focus) {
        _focus = [[Focus alloc] init];
    }
    return _focus;
}

- (UICollectionView *)theCollectionView{
    if (!_theCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 10;
        CGFloat width = (self.view.bounds.size.width - 30) / 2;
        flowLayout.itemSize = CGSizeMake(width, width);
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _theCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:flowLayout];
        _theCollectionView.dataSource = self;
        _theCollectionView.delegate = self;
        [_theCollectionView registerNib:[UINib nibWithNibName:@"FocusMoreCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"focusMoreCollectionViewCell"];
        _theCollectionView.backgroundColor = KLightGreen;
    }
    return _theCollectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = KLightGreen;
    
    self.navigationItem.title = self.focus.title;
    [self.view addSubview:self.theCollectionView];
    [self requestData];
    
}


- (void)requestData{
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/index_places/%@/", self.focus.index];
    
    [RequestManager requestManager:urlString finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.focus = [[Focus alloc] init];
        [self.focus setValuesForKeysWithDictionary:jsonDic];
        self.navigationItem.title = self.focus.title;

        [self.theCollectionView reloadData];
        
    } error:^(NSError *error) {
        
    }];
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.focus.dataList.count;    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FocusMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"focusMoreCollectionViewCell" forIndexPath:indexPath];
    [cell cellCongifureWithNearByItem:self.focus.dataList[indexPath.item]];
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FocusPlaceDetaliViewController *focusPlaceDetailVC = [[FocusPlaceDetaliViewController alloc] init];
    focusPlaceDetailVC.nearByItem = self.focus.dataList[indexPath.item];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:focusPlaceDetailVC];
    
    [self presentViewController:navigation animated:YES completion:nil];
    

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
