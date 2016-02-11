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
    JFMinimalNotification * _notification;
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    if (_notification != nil) {
        [_notification dismiss];
    }
    
    [super touchesBegan:touches withEvent:event];
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


#pragma mark - JFMinimalNotification
- (void)showDefaultNotificationWithTitle:(NSString *)title Message:(NSString *)msg
{
    [self showNotificationWithStyle:JFMinimalNotificationStyleDefault Title:title Message:msg];
}

- (void)showErrorNotificationWithTitle:(NSString *)title Message:(NSString *)msg
{
    [self showNotificationWithStyle:JFMinimalNotificationStyleError Title:title Message:msg];
}

- (void)showSuccessNotificationWithTitle:(NSString *)title Message:(NSString *)msg
{
    [self showNotificationWithStyle:JFMinimalNotificationStyleSuccess Title:title Message:msg];
}

- (void)showInfoNotificationWithTitle:(NSString *)title Message:(NSString *)msg
{
    [self showNotificationWithStyle:JFMinimalNotificationStyleInfo Title:title Message:msg];
}

- (void)showWarningNotificationWithTitle:(NSString *)title Message:(NSString *)msg
{
    [self showNotificationWithStyle:JFMinimalNotificationStyleWarning Title:title Message:msg];
}

- (void)showNotificationWithStyle:(JFMinimalNotificationStyle)style Title:(NSString *)title Message:(NSString *)msg
{
    _notification = [JFMinimalNotification notificationWithStyle:style
                                                           title:title
                                                        subTitle:msg
                                                  dismissalDelay:5.0
                                                    touchHandler:^
                     {
                         [_notification dismiss];
                     }];
    
    [self showNotification:_notification];
}

- (void)showNotification:(JFMinimalNotification *)notification
{
    UIFont * titleFont = [UIFont systemFontOfSize:20];
    [notification setTitleFont:titleFont];
    
    UIFont * subTitleFont = [UIFont systemFontOfSize:13];
    [notification setSubTitleFont:subTitleFont];
    
    notification.edgePadding = UIEdgeInsetsMake(0, 0, 10, 0);
    
    [self.view addSubview:notification];
    
    [notification show];
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
    [self showErrorNotificationWithTitle:@"Error" Message:@"Error for location. Check the state of your GPS"];
}

@end
