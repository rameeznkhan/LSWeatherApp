//
//  CityListViewController.h
//  LSWeatherApp
//
//  Created by rameez khan on 22/08/15.
//  Copyright (c) 2015 rameez khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *cityArray;

@end
