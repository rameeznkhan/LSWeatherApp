//
//  FetchData.m
//  LSWeatherApp
//
//  Created by rameez khan on 22/08/15.
//  Copyright (c) 2015 rameez khan. All rights reserved.
//

#import "FetchData.h"
#define COUNT 14
#define API_KEY "83ef81e3f7d6c74274d112cc6a223073"
@implementation FetchData
-(void)fetchWeatherDataWithCity: (NSString *)city completion:(void (^)(NSDictionary *finished))completion
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&cnt=%d&APPID=%s",city,COUNT,API_KEY];
    NSString* webStringURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:webStringURL];
    NSLog(@"url is %@",url);
    static NSURLSession* sharedSessionMainQueue = nil;
    if(!sharedSessionMainQueue){
        sharedSessionMainQueue = [NSURLSession sessionWithConfiguration:nil delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    NSURLSessionDataTask *dataTask =
    [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                          NSURLResponse *response,
                                                                          NSError *error){
        _forecastDict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //now will be on main thread
        if (completion) {
            completion(_forecastDict);
        }
        
    }];
    [dataTask resume];
}

-(void)fetchWeatherDataWithCity: (float )latitude andLongitude:(float)longitude completion:(void (^)(NSDictionary *finished))completion
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&cnt=%d&APPID=%s",latitude,longitude,COUNT,API_KEY];
    NSString* webStringURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:webStringURL];
    NSLog(@"url is %@",url);
    static NSURLSession* sharedSessionMainQueue = nil;
    if(!sharedSessionMainQueue){
        sharedSessionMainQueue = [NSURLSession sessionWithConfiguration:nil delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    NSURLSessionDataTask *dataTask =
    [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                          NSURLResponse *response,
                                                                          NSError *error){
        _forecastDict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //now will be on main thread
        if (completion) {
            completion(_forecastDict);
        }
        
    }];
    [dataTask resume];
}

@end
