//
//  DetailViewController.m
//  LSWeatherApp
//
//  Created by rameez khan on 22/08/15.
//  Copyright (c) 2015 rameez khan. All rights reserved.
//

#import "DetailViewController.h"
#import "FetchData.h"
#import "CurrentLocation.h"
#import "MBProgressHUD.h"
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,LocationControllerDelegate>
@property(nonatomic,strong) NSArray *weatherDataArray;
@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;
@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_weatherTableView setDataSource:self];
    [_weatherTableView setDelegate:self];
    [_weatherTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DetailCell"];
    [_weatherTableView setBackgroundColor:[UIColor clearColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    FetchData *weatherData = [[FetchData alloc]init];
    if (_cityName) {
        [weatherData fetchWeatherDataWithCity:_cityName completion:^(NSDictionary *finished) {
            NSDictionary *nameDict = [finished valueForKey:@"city"];
            _weatherDataArray = [finished valueForKey:@"list"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.title = [nameDict valueForKey:@"name"];
                [_weatherTableView reloadData];
                [MBProgressHUD hideAllHUDsForView:self.view  animated:YES];
            });
        }];
    }else{
        CurrentLocation *myLocation = [CurrentLocation sharedManager];
        [myLocation setLocationDelegate:self];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_weatherDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DetailCell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *mainDict =[_weatherDataArray objectAtIndex:indexPath.row];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[mainDict valueForKey:@"dt"]doubleValue ]];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"dd-MMM-yyyy";
    NSArray *weatherArray = [mainDict valueForKey:@"weather"];
    NSDictionary *subDict = [weatherArray objectAtIndex:0];
    cell.textLabel.text = [subDict valueForKey:@"description"];
    cell.detailTextLabel.text = [format stringFromDate:date];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma CurrentLocation Delegate
-(void)locationUpdate:(CLLocation *)location{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    FetchData *weatherData = [[FetchData alloc]init];
    [weatherData fetchWeatherDataWithCity:location.coordinate.latitude andLongitude:location.coordinate.longitude completion:^(NSDictionary *finished) {
        if (finished) {
            NSDictionary *nameDict = [finished valueForKey:@"city"];
            _weatherDataArray = [finished valueForKey:@"list"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.title = [nameDict valueForKey:@"name"];
                [_weatherTableView reloadData];
                [MBProgressHUD hideAllHUDsForView:self.view  animated:YES];
            });
        }
    }];
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
