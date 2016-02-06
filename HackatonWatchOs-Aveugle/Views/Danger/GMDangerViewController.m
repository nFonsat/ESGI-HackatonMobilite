//
//  GMDangerViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 04/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMDangerViewController.h"

@interface GMDangerViewController ()
{
    @private
    BOOL _needUpdateUserLocation;
}

@property (weak, nonatomic) IBOutlet MKMapView * mapView;

@property (weak, nonatomic) IBOutlet UITextField * nameField;
@property (weak, nonatomic) IBOutlet UIButton * typeButton;

- (IBAction)selectTypeAction:(UIButton *)sender;

- (IBAction)validDangerAction:(UIButton *)sender;
- (IBAction)cancelDangerAction:(UIButton *)sender;

@end

@implementation GMDangerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initMapView];
    
    
    self.typeButton.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.typeButton.layer.cornerRadius = 5;
}

#pragma mark - MapView

- (void)initMapView
{
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    _needUpdateUserLocation = YES;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (_needUpdateUserLocation) {
        _needUpdateUserLocation = NO;
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 100, 100);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    }
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"MapKit didFailToLocateUserWithError : %@", error.localizedDescription);
    _needUpdateUserLocation = YES;
}

#pragma mark - GMBaseViewController

- (UIColor *)getBarTintColor
{
    return [UIColor dangerColor];
}

- (NSString *)getTitle
{
    return @"Danger";
}

- (IBAction)selectTypeAction:(UIButton *)sender
{
    
}

- (IBAction)validDangerAction:(UIButton *)sender
{
    NSLog(@"Coordinate : %f,%f", self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude);
}

- (IBAction)cancelDangerAction:(UIButton *)sender
{
    
}

@end
