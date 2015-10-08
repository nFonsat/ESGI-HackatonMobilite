//
//  ViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate> {
    @private
    CLLocationManager* locationManager;
    BOOL locationFound;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMapView];
    
    [self initLocationManager];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MapView impl

- (void)initMapView {
    locationFound = false;
    self.mapView.showsUserLocation = true;
    self.mapView.delegate = self;
}


#pragma mark - CoreLocation impl

- (void)initLocationManager {
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    if (!locationFound) {
        locationFound = true;
        
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        
        CLLocationCoordinate2D location;
        
        location.latitude = userLocation.coordinate.latitude;
        location.longitude = userLocation.coordinate.longitude;
        
        region.span = span;
        region.center = location;
        
        [self.mapView setRegion:region animated:YES];
        
        [self.mapView setCenterCoordinate:location];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSString* statusString;
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            statusString = @"User has not yet made a choice with regards to this application";
            [locationManager requestAlwaysAuthorization];
            break;
            
        case kCLAuthorizationStatusRestricted:
            statusString = @"This application is not authorized to use location services";
            
        case kCLAuthorizationStatusDenied:
            statusString = @"User has explicitly denied authorization for this application";
            [locationManager requestAlwaysAuthorization];
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
            statusString = @"User has granted authorization to use their location at any time";
            [locationManager startUpdatingLocation];
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            statusString = @"User has granted authorization to use their location only when your app is visible";
            [locationManager startUpdatingLocation];
            break;
            
        default:
            statusString = @"Not found status";
            break;
    }
    
    NSLog(@"Authorization => %@", statusString);
}

@end
