//
//  TripsTableViewCell.m
//  Product_B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import "TripsTableViewCell.h"
#import "Trip.h"
#import "Spot.h"
#import "User.h"
#import "Waypoint.h"
#import "TripListModel.h"
#import <UIButton+WebCache.h>

@implementation TripsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = kTableViewColor;
    
    self.iconButton.layer.cornerRadius = 25 / 2.0;
    self.iconButton.clipsToBounds = YES;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfigureWithIndexRow:(NSInteger)indexRow{
    
    // 首先获取shareModel
    TripListModel *shareModel = [TripListModel shareTripListModel];
    // 根据indexRow获取印象中的trips
    NSArray *trips = shareModel.trips;
    // 获取trip
    Trip *trip = trips[indexRow][@"trip"];
    
    // 配置cell
    // 1. 配置用户头像与用户名
    User *user = trip.theUser;
    [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:user.avatar_s] forState:(UIControlStateNormal)];
    self.unameLable.text = user.name;
    
    // 配置事件
    self.timeLabel.text = [[trip.date_added componentsSeparatedByString:@"T"] firstObject];
    
    
    //  配置scrollerView
    //  首先移除scrollerView上面所有的imageView
    NSArray *views = self.theScrollerView.subviews;
    for (int i = 0; i < views.count; i ++) {
        [views[i] removeFromSuperview];
    }
    
    //  配置介绍, 同时重置scrollview;
    
    NSDictionary *tripDic = trips[indexRow];
    if ([tripDic.allKeys containsObject:@"spot"]) {
        [self configureZeroRow:trips withRow:indexRow];
    }
    
    if ([tripDic.allKeys containsObject:@"waypoints"]) {
        [self configureOneRow:trips withRow:indexRow];
    }
    
    
}


- (void)configureZeroRow:(NSArray *)trips withRow:(NSInteger)indexRow{
    // 获取spot
    Spot *spot = trips[indexRow][@"spot"];
    //  配置介绍
    self.spotTextLabel.text = spot.text;
    
    // 历遍spotDetail数组中所有的图片, 并添加到scrolleview上面
    // 定义scrollerView的contentsize的width
    CGFloat theScollerViewContentWidth = 0;
    NSArray<SpotDetail *> *theDetailList = spot.theDetail_list;
    for (int i = 0; i < theDetailList.count; i ++) {
        SpotDetail *spotDetail = theDetailList[i];
        // 获取图片的url
        NSURL *url = [NSURL URLWithString:spotDetail.photo];
        // 计算图片的宽高比
        CGFloat ratio = spotDetail.photo_width.floatValue / spotDetail.photo_height.floatValue;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(theScollerViewContentWidth, 0, 100 * ratio, 100)];
        theScollerViewContentWidth += (5 + 100 * ratio);
        
        // 添加到scrollerview上面
        [self.theScrollerView addSubview:imageView];
        imageView.backgroundColor = [UIColor orangeColor];
        [imageView sd_setImageWithURL:url];
    }
    theScollerViewContentWidth -= 5;
    // 设置scrollview的contentsize
    self.theScrollerView.contentSize = CGSizeMake(theScollerViewContentWidth, 100);
}

- (void)configureOneRow:(NSArray *)trips withRow:(NSInteger)indexRow{
    
    NSDictionary *tripDic = trips[indexRow];
    //  配置介绍
    self.spotTextLabel.text = tripDic[@"trip_text"];
    // 定义scrollerView的contentsize的width
    CGFloat theScollerViewContentWidth = 0;
    NSArray<Waypoint *> *wayPoints = tripDic[@"waypoints"];
    for (int i = 0; i < wayPoints.count ; i++) {
        Waypoint *wayPoint = wayPoints[i];
        // 获取图片url
        NSURL *url = [NSURL URLWithString:wayPoint.photo];
        
        // 获取图片的宽高比
        NSNumber *w = wayPoint.photo_info[@"w"];
        NSNumber *h = wayPoint.photo_info[@"h"];
        CGFloat ratio = w.floatValue / h.floatValue;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(theScollerViewContentWidth, 0, 100 * ratio, 100)];
        theScollerViewContentWidth += (5 + 100 * ratio);
        
        // 添加到scrollerview上面
        [self.theScrollerView addSubview:imageView];
        imageView.backgroundColor = [UIColor orangeColor];
        [imageView sd_setImageWithURL:url];
    }
    theScollerViewContentWidth -= 5;
    // 设置scrollview的contentsize
    self.theScrollerView.contentSize = CGSizeMake(theScollerViewContentWidth, 100);
    
}

@end
