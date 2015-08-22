//
//  FetchData.h
//  LSWeatherApp
//
//  Created by rameez khan on 22/08/15.
//  Copyright (c) 2015 rameez khan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchData : NSObject<NSURLSessionDataDelegate,NSURLSessionDelegate>
@property(nonatomic,strong) NSDictionary *forecastDict;
-(void)fetchWeatherDataWithCity: (NSString *)city completion:(void (^)(NSDictionary *finished))completion;
-(void)fetchWeatherDataWithCity: (float )latitude andLongitude:(float)longitude completion:(void (^)(NSDictionary *finished))completion;
@end
