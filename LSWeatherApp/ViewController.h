//
//  ViewController.h
//  LSWeatherApp
//
//  Created by rameez khan on 22/08/15.
//  Copyright (c) 2015 rameez khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *citiesLabel;
- (IBAction)cityListButtonTapped:(id)sender;
- (IBAction)currentLocationTapped:(id)sender;


@end

