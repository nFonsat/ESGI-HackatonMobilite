//
//  GMLocationMapViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMLocationMapViewController.h"

@interface GMLocationMapViewController ()
{
    @private
    CLLocationManager * _locationManager;
    GMLocation * _locationForZoom;
    BOOL _centerOnUserPosition;
    BOOL _needUpdateUserLocation;
}

@property (weak, nonatomic) IBOutlet MKMapView * mapView;

@end

@implementation GMLocationMapViewController

- (instancetype)init
{
    if (self = [super init]) {
        [self initLocationManager];
        _centerOnUserPosition = YES;
    }

    return self;
}

- (instancetype)initWithGMLocation:(GMLocation *)location
{
    if (self = [self init]) {
        _locationForZoom = location;
        _centerOnUserPosition = NO;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initMapView];
}

#pragma mark - GMLocationMapViewController Helper

- (void) zoomOnLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    
    CLLocationCoordinate2D location;
    
    location.latitude = latitude;
    location.longitude = longitude;
    
    region.span = span;
    region.center = location;
    
    [self.mapView setRegion:region animated:YES];
    
    [self.mapView setCenterCoordinate:location];
}

#pragma mark - MapView

- (void)initMapView
{
    self.mapView.showsUserLocation = _centerOnUserPosition;
    self.mapView.delegate = self;
    _needUpdateUserLocation = _centerOnUserPosition;
    
    if (!_centerOnUserPosition && _locationForZoom) {
        CLLocationDegrees latitude = _locationForZoom.coordinate.latitude;
        CLLocationDegrees longitude = _locationForZoom.coordinate.longitude;
        [self zoomOnLatitude:latitude andLongitude:longitude];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (_needUpdateUserLocation) {
        _needUpdateUserLocation = NO;
        
        CLLocationDegrees latitude = userLocation.coordinate.latitude;
        CLLocationDegrees longitude = userLocation.coordinate.longitude;
        [self zoomOnLatitude:latitude andLongitude:longitude];
    }
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"MapKit didFailToLocateUserWithError : %@", error.localizedDescription);
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
