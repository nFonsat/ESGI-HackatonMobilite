//
//  GMBaseViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 09/01/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMBaseViewController.h"

@interface GMBaseViewController ()
{
@private
    CLLocationManager * _locationManager;
}

- (UIColor *)getBackgroundColor;

- (UIColor *)getBarTintColor;

- (UIColor *)getTintColor;

- (NSString *)getTitle;

- (UIColor *)getTitleColor;

@end

@implementation GMBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initLocationManager];
    
    [self setTitle:[self getTitle]];
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"";
    [self.navigationController.navigationBar.topItem setBackBarButtonItem:backButton];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [self getTitleColor]}];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view setBackgroundColor:[self getBackgroundColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBarTintColor:[self getBarTintColor]];
    [self.navigationController.navigationBar setTintColor:[self getTintColor]];
    
    [super viewWillAppear:animated];
}

#pragma mark - GMBaseViewController

- (UIColor *)getBackgroundColor
{
    return [UIColor blackColor];
}

- (UIColor *)getBarTintColor
{
    return [UIColor blackColor];
}

- (UIColor *)getTintColor
{
    return [UIColor whiteColor];
}

- (NSString *)getTitle
{
    return @"";
}

- (UIColor *)getTitleColor
{
    return [UIColor whiteColor];
}



#pragma mark - CoreLocation

- (void)initLocationManager
{
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [_locationManager requestAlwaysAuthorization];
            break;
            
        case kCLAuthorizationStatusRestricted:
            [_locationManager requestAlwaysAuthorization];
            break;
            
        case kCLAuthorizationStatusDenied:
            [_locationManager requestAlwaysAuthorization];
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
            [_locationManager startUpdatingLocation];
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [_locationManager startUpdatingLocation];
            break;
            
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"CoreLocation didFailWithError : %@", error.localizedDescription);
}

@end
