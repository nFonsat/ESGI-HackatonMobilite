//
//  GMLocationMapViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMLocationMapViewController.h"
#import "GMWebLocationAPI.h"
#import "GMDangerWebAPI.h"
#import "GMDanger.h"
#import "UIColor+GMColor.h"

@interface GMLocationMapViewController ()
{
@private
    GMWebLocationAPI * _locationWeb;
    GMDangerWebAPI * _dangerWebAPI;
    NSMutableArray<GMDanger *> * _dangersOnMap;
    MKRoute * _routeDetails;
    GMLocation * _locationForZoom;
    BOOL _centerOnUserPosition;
    BOOL _needUpdateUserLocation;
    BOOL _startNavigation;
    BOOL _bottomBarIsOpen;
    BOOL _mapFullyRendered;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint * constraintBottomOnBottomBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * constraintTopOnTopBar;

@property (weak, nonatomic) IBOutlet MKMapView * mapView;
@property (weak, nonatomic) IBOutlet UISearchBar * searchBar;

@property (weak, nonatomic) IBOutlet UIButton * navigateBtn;
@property (weak, nonatomic) IBOutlet UIButton * magnifierBtn;

@property (weak, nonatomic) IBOutlet UIView * bottomBar;
@property (weak, nonatomic) IBOutlet UILabel * distanceToNextStepLabel;
@property (weak, nonatomic) IBOutlet UILabel * directionLabel;
@property (weak, nonatomic) IBOutlet UIImageView * arrowImg;

@property (weak, nonatomic) IBOutlet UIView * topBar;
@property (weak, nonatomic) IBOutlet UILabel * destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel * distanceToDestinationLabel;

- (IBAction)navigateAction:(UIButton *)sender;
- (IBAction)magnifierAction:(UIButton *)sender;

@end

@implementation GMLocationMapViewController

- (instancetype)init
{
    if (self = [super init]) {
        _locationWeb = [[GMWebLocationAPI alloc] init];
        _dangerWebAPI = [[GMDangerWebAPI alloc] init];
        _startNavigation = NO;
        _centerOnUserPosition = YES;
        _mapFullyRendered = NO;
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
    
    [self initMapView];
    
    [self stopNavigation];
}

- (void)viewDidAppear:(BOOL)animated
{
    _dangersOnMap = [NSMutableArray new];
}

#pragma mark - GMBaseViewController

- (UIColor *)getBarTintColor
{
    return [UIColor mapColor];
}

- (NSString *)getTitle
{
    return @"Map";
}

#pragma mark - GMLocationMapViewController Action

- (IBAction)navigateAction:(UIButton *)sender
{
    if (!_startNavigation) {
        [_locationWeb playLocation:_locationForZoom.locationId
                           Success:^(id responseObject)
        {
            NSLog(@"%@", responseObject);
            [self calculateDirection];
        }
                           Failure:^(NSError * error)
        {
            NSLog(@"%@", error);
            [self calculateDirection];
        }];
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
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

- (void) enabledNavigateBtn:(BOOL)enabled
{
    self.navigateBtn.hidden = !enabled;
    self.navigateBtn.userInteractionEnabled = enabled;
}

- (void)showBarNavigation
{
    [_constraintBottomOnBottomBar setConstant:0];
    [_constraintTopOnTopBar setConstant:0];
    _bottomBarIsOpen = YES;
}

- (void)showBarNavigationWithAnimation
{
    [UIView animateWithDuration:1 animations:^(void)
     {
         [self showBarNavigation];
     }];
}

- (void)hideBarNavigation
{
    CGSize bottomBarSize = _bottomBar.frame.size;
    CGSize topBarSize    = _topBar.frame.size;
    
    [_constraintBottomOnBottomBar setConstant:(-bottomBarSize.height)];
    [_constraintTopOnTopBar setConstant:(-topBarSize.height)];
    _bottomBarIsOpen = NO;
}

- (void)hideBarNavigationWithAnimation
{
    [UIView animateWithDuration:1 animations:^(void)
     {
         [self hideBarNavigation];
     }];
}

- (void)turnArrowToCenter
{
    _arrowImg.transform = CGAffineTransformMakeRotation(0);
}

- (void)turnArrowToRight
{
    _arrowImg.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)turnArrowToLeft
{
    _arrowImg.transform = CGAffineTransformMakeRotation(-M_PI_2);
}

- (void) startNavigation
{
    _startNavigation = YES;
    [self.navigateBtn setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [self showBarNavigationWithAnimation];
}

- (void) stopNavigation
{
    _startNavigation = NO;
    [self.navigateBtn setImage:[UIImage imageNamed:@"map-locator"] forState:UIControlStateNormal];
    [self.mapView removeOverlays:self.mapView.overlays];
    [self hideBarNavigationWithAnimation];
}

- (void)calculateDirection
{
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
             
             [self.mapView removeOverlays:self.mapView.overlays];
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
             
             [self loadNextInstruction: _routeDetails.steps[1]];
             [self loadGeneralInstruction:_routeDetails];
             
             [self startNavigation];
         }
     }];
}

- (void)loadNextInstruction:(MKRouteStep *)instruction
{
    _distanceToNextStepLabel.text = [NSString stringWithFormat:@"%ld m", (long)instruction.distance];
    _directionLabel.text = instruction.instructions;
    
    if ([instruction.instructions rangeOfString:@"right"].location != NSNotFound) {
        [self turnArrowToRight];
    }
    else if ([instruction.instructions rangeOfString:@"left"].location != NSNotFound){
        [self turnArrowToLeft];
    }
    else {
        [self turnArrowToCenter];
    }
}

- (void)loadGeneralInstruction:(MKRoute *)instruction
{
    _distanceToDestinationLabel.text = [NSString stringWithFormat:@"%ld m", (long)instruction.distance];
    _destinationLabel.text = _locationForZoom.name;
}

- (void)addDangerOnMap:(GMDanger *)danger
{
    
    if (![_dangersOnMap containsObject:danger]) {
        [_dangersOnMap addObject:danger];
        
        MKPointAnnotation * point = [[MKPointAnnotation alloc] init];
        point.coordinate = danger.coordinate;
        point.title = danger.name;
        
        [self.mapView addAnnotation:point];
    }
}

- (void)detectDangerForUserLocation:(MKUserLocation *)userLocation
{
    GMDanger * dangerSignal = nil;
    
    for (GMDanger * danger in _dangersOnMap) {
        if ([self danger:danger isNearUserLocation:userLocation AndDistance:5]) {
            dangerSignal = danger;
            break;
        }
    }
    
    if (dangerSignal != nil) {
        NSLog(@"Find danger to signal : %@", dangerSignal);
    }
    
}

- (BOOL)danger:(GMDanger *)danger isNearUserLocation:(MKUserLocation *)userLocation AndDistance:(CLLocationDistance)distance
{
    double xPosition = danger.coordinate.latitude - userLocation.coordinate.latitude;
    double yPosition = danger.coordinate.longitude - userLocation.coordinate.longitude;
    
    return sqrt(pow(xPosition, 2) + pow(yPosition, 2)) < distance;
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
    
    if (_startNavigation) {
        [self calculateDirection];
    }
    
    [self detectDangerForUserLocation:userLocation];
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"MapKit didFailToLocateUserWithError : %@", error.localizedDescription);
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {

    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *pr = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        pr.strokeColor = [UIColor greenColor];
        pr.lineWidth = 5;
        return pr;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (_mapFullyRendered) {
        MKMapRect mRect = self.mapView.visibleMapRect;
        MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
        MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
        CLLocationDistance distance = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint)/2;
        
        [_dangerWebAPI getDangersFromCenter:self.mapView.region.center
                                   Distance:@(distance)
                                    Success:^(id responseObject)
         {
             for (NSDictionary * dangerJson in responseObject) {
                 GMDanger * danger = [[GMDanger alloc]initFromJsonDictionary:dangerJson];
                 [self addDangerOnMap:danger];
             }
         }
                                    Failure:^(AFHTTPRequestOperation * operation, NSError *error)
         {
             NSLog(@"Failure : %@", operation.responseObject);
         }];
    }
}

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    _mapFullyRendered = fullyRendered;
}

@end
