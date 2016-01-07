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
    MKRoute * _routeDetails;
    GMLocation * _locationForZoom;
    BOOL _centerOnUserPosition;
    BOOL _needUpdateUserLocation;
    BOOL _startNavigation;
    BOOL _bottomBarIsOpen;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint * constraintBottomOnBottomBar;

@property (weak, nonatomic) IBOutlet MKMapView * mapView;
@property (weak, nonatomic) IBOutlet UISearchBar * searchBar;

@property (weak, nonatomic) IBOutlet UIButton * navigateBtn;
@property (weak, nonatomic) IBOutlet UIButton * magnifierBtn;

@property (weak, nonatomic) IBOutlet UIView * bottomBar;
@property (weak, nonatomic) IBOutlet UILabel * distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel * directionLabel;
@property (weak, nonatomic) IBOutlet UIImageView * arrowImg;

- (IBAction)navigateAction:(UIButton *)sender;
- (IBAction)magnifierAction:(UIButton *)sender;

@end

@implementation GMLocationMapViewController

- (instancetype)init
{
    if (self = [super init]) {
        [self initLocationManager];
        _startNavigation = NO;
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
    
    self.searchBar.hidden = YES;
    
    [self stopNavigation];
    
    [self initMapView];
    
    [self hideBottomBar];
}

#pragma mark - GMLocationMapViewController Action

- (IBAction)navigateAction:(UIButton *)sender
{
    if (!_startNavigation) {
        [self calculateDirection];
    }
    else {
        [self stopNavigation];
    }
}

- (IBAction)magnifierAction:(UIButton *)sender
{
    self.searchBar.hidden = !self.searchBar.hidden;
}


#pragma mark - GMLocationMapViewController Helper

- (void)zoomOnCoordinate:(CLLocationCoordinate2D)coordinate
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

- (void) enabledNavigateBtn:(BOOL)enabled
{
    self.navigateBtn.hidden = !enabled;
    self.navigateBtn.userInteractionEnabled = enabled;
}

- (void)showBottomBar
{
    [_constraintBottomOnBottomBar setConstant:0];
    _bottomBarIsOpen = YES;
}

- (void)showBottomBarWithAnimation
{
    [UIView animateWithDuration:1 animations:^(void)
     {
         [self showBottomBar];
     }];
}

- (void)hideBottomBar
{
    CGSize bottomBarSize = self.bottomBar.frame.size;
    [_constraintBottomOnBottomBar setConstant:(-bottomBarSize.height)];
    _bottomBarIsOpen = NO;
}

- (void)hideBottomBarWithAnimation
{
    [UIView animateWithDuration:1 animations:^(void)
     {
         [self hideBottomBar];
     }];
}

#pragma mark - MapView

- (void)initMapView
{
    [self enabledNavigateBtn:NO];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    _needUpdateUserLocation = _centerOnUserPosition;
    
    if (!_centerOnUserPosition && _locationForZoom) {
        [self zoomOnCoordinate:_locationForZoom.coordinate];
        
        MKPointAnnotation * point = [[MKPointAnnotation alloc] init];
        point.coordinate = _locationForZoom.coordinate;
        point.title = _locationForZoom.name;
        
        [self.mapView addAnnotation:point];
        [self enabledNavigateBtn:YES];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (_needUpdateUserLocation) {
        _needUpdateUserLocation = NO;
        [self zoomOnCoordinate:userLocation.coordinate];
    }
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"MapKit didFailToLocateUserWithError : %@", error.localizedDescription);
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer  * routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:_routeDetails.polyline];
    
    routeLineRenderer.strokeColor = [UIColor greenColor];
    routeLineRenderer.lineWidth = 5;
    
    return routeLineRenderer;
}

- (void)calculateDirection
{
    [self enabledNavigateBtn:NO];
    
    MKDirectionsRequest * directionsRequest = [[MKDirectionsRequest alloc] init];
    [directionsRequest setSource:[MKMapItem mapItemForCurrentLocation]];
    
    MKPlacemark * placeMarkDestination = [[MKPlacemark alloc] initWithCoordinate:_locationForZoom.coordinate addressDictionary:nil];
    [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:placeMarkDestination]];
    
    directionsRequest.transportType = MKDirectionsTransportTypeWalking;
    
    MKDirections * directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error)
     {
         if (error) {
             NSLog(@"Error %@", error.description);
             [self stopNavigation];
         }
         else {
             _routeDetails = response.routes.lastObject;
             
             [self.mapView addOverlay:_routeDetails.polyline];
             NSLog(@"Distance : %d", (int) _routeDetails.distance);
             
             NSString * allSteps = @"";
             for (int i = 0; i < _routeDetails.steps.count; i++) {
                 MKRouteStep *step = [_routeDetails.steps objectAtIndex:i];
                 NSString *newStep = step.instructions;
                 
                 allSteps = [allSteps stringByAppendingString:newStep];
                 allSteps = [allSteps stringByAppendingString:@"\n\n"];
             }
             NSLog(@"Steps : %@",  allSteps);
             
             [self startNavigation];
         }
     }];
}

- (void) startNavigation
{
    _startNavigation = YES;
    [self.navigateBtn setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
}

- (void) stopNavigation
{
    _startNavigation = NO;
    [self.navigateBtn setImage:[UIImage imageNamed:@"map-locator"] forState:UIControlStateNormal];
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
