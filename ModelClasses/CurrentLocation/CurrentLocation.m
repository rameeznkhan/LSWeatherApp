//
//  CurrentLocation.m
//  LSWeatherApp
//
//  Created by rameez khan on 22/08/15.
//  Copyright (c) 2015 rameez khan. All rights reserved.
//

#import "CurrentLocation.h"

@implementation CurrentLocation
#pragma mark - Singleton implementation in ARC
static CurrentLocation * sharedCLDelegate = nil;


+ (instancetype)sharedManager
{
    static CurrentLocation *sharedLocationControllerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedLocationControllerInstance = [[self alloc] init];
    });
    return sharedLocationControllerInstance;
}



- (id)init {
    if (self = [super init]) {
        // 1
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
            [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
            //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
            ) {
            // Will open an confirm dialog to get user's approval
            [_locationManager requestWhenInUseAuthorization];
            [_locationManager startUpdatingLocation];
        } else {
            [_locationManager startUpdatingLocation]; //Will update location immediately
        }
        
    }
    return self;
}

- (void)findCurrentLocation {
    self.isFirstUpdate = YES;
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (self.isFirstUpdate) {
        self.isFirstUpdate = NO;
        return;
    }
    
    CLLocation *location = [locations lastObject];
    
    if (location.horizontalAccuracy > 0) {
        self.currentLocation = location;
        [self.locationManager stopUpdatingLocation];
        [_locationDelegate locationUpdate:_currentLocation];
        //_locationManager.delegate =nil;
        //just to save power as sometimes stopupdating location doesnt help
    }
}
@end
