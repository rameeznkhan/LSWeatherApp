//
//  ViewController.m
//  LSWeatherApp
//
//  Created by rameez khan on 22/08/15.
//  Copyright (c) 2015 rameez khan. All rights reserved.
//

#import "ViewController.h"
#import "CityListViewController.h"
#import "DetailViewController.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            if ([[alertView textFieldAtIndex:0].text isEqualToString:@""]) {
                [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
                if (![_citiesLabel.text isEqualToString:@""]) {
                    NSString *allCities = _citiesLabel.text;
                    NSArray *array = [allCities componentsSeparatedByString:@" "];
                    NSMutableArray *citiesArray = [NSMutableArray arrayWithArray:array];
                    [citiesArray removeLastObject];
                    CityListViewController *cityViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CityListViewController"];
                    cityViewController.cityArray = citiesArray;
                    [self.navigationController pushViewController:cityViewController animated:YES];

                }
                break;
            }else{
                NSString *cityName = [alertView textFieldAtIndex:0].text;
            cityName = [cityName stringByAppendingString:@" "];
            _citiesLabel.text = [_citiesLabel.text stringByAppendingString:cityName];
            NSString *allCities = _citiesLabel.text;
            NSArray *array = [allCities componentsSeparatedByString:@" "];
            NSMutableArray *citiesArray = [NSMutableArray arrayWithArray:array];
            [citiesArray removeLastObject];
            CityListViewController *cityViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CityListViewController"];
            cityViewController.cityArray = citiesArray;
            [self.navigationController pushViewController:cityViewController animated:YES];
            break;
            }
        }
        case 1:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter more cities" message:@"Please enter city" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            NSString *cityName = [alertView textFieldAtIndex:0].text;
            cityName =[cityName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (![cityName isEqualToString:@""]) {
                cityName = [cityName stringByAppendingString:@" "];
                _citiesLabel.text = [_citiesLabel.text stringByAppendingString:cityName];
            }
            [alert show];
            
            break;
        }
        default:
            break;
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_citiesLabel setText:@""];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cityListButtonTapped:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add city" message:@"Enter the name of the city" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (IBAction)currentLocationTapped:(id)sender {
    DetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end
