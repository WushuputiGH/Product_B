//
//  NearByMacro.h
//  Product_B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 H. All rights reserved.
//

#ifndef NearByMacro_h
#define NearByMacro_h

// 附件文件中, 全部的接口
// 刷新接口
#define kNearByAllRefresh @"http://api.breadtrip.com/place/pois/nearby/?category=0&start=0&count=20&latitude=%f&longitude=%f"
// 加载更多接口
#define kNearByAllMore

#define kTableViewColor [UIColor colorWithRed:253.0 / 255 green:245.0 / 255 blue:230.0 /255 alpha:1.00f] // 253, 245, 230

#define kPlaceHolderImage1 [UIImage imageNamed:@"placeHolder1.jpg"]
#define kPlaceHolderImage2 [UIImage imageNamed:@"placeHolder2.jpg"]
#define kPlaceHolderImage3 [UIImage imageNamed:@"placeHolder3.jpg"]



#endif /* NearByMacro_h */
