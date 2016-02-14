//
//  GMDangerViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 04/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMDangerViewController.h"
#import "GMDangerWebAPI.h"

@interface GMDangerViewController ()
{
    @private
    BOOL _needUpdateUserLocation;
    GMTypeDanger * _typeDanger;
    GMDangerWebAPI * _dangerWebAPI;
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
    
    _dangerWebAPI = [GMDangerWebAPI sharedDangerWebAPI];
    
    [self initMapView];
    
    self.typeButton.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.typeButton.layer.cornerRadius = 5;
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

#pragma mark - GMDangerViewController Helper UI

- (void)updateTypeDangerBtn
{
    if (_typeDanger != nil) {
        [self.typeButton setTitle:_typeDanger.name forState:UIControlStateNormal];
        [self.typeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else {
        [self.typeButton setTitle:@"Press to select type" forState:UIControlStateNormal];
        [self.typeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (BOOL)formIsValid
{
    NSString * name = self.nameField.text;
    if (name == nil || [name isEmpty]) {
        [self showErrorNotificationWithMessage:@"Name of danger is undefined"];
        return NO;
    }
    else if (_typeDanger == nil) {
        [self showErrorNotificationWithMessage:@"Type of danger is undefined"];
        return NO;
    }
    
    return YES;
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
    [self showErrorNotificationWithMessage:@"Impossible located user"];
    _needUpdateUserLocation = YES;
}

#pragma mark - GMDangerViewController Action

- (IBAction)selectTypeAction:(UIButton *)sender
{
    GMTypeDangerViewController * typesDangerView = [GMTypeDangerViewController new];
    typesDangerView.delegate = self;
    [self.navigationController pushViewController:typesDangerView animated:YES];
}

- (IBAction)validDangerAction:(UIButton *)sender
{
    if ([self formIsValid]) {
        NSString * name = self.nameField.text;
        CLLocationCoordinate2D coordinate = self.mapView.centerCoordinate;
        
        [_dangerWebAPI postDangerWithName:name
                               Coordinate:coordinate
                                     Type:_typeDanger
                                  Success:^(id responseObject)
         {
             [self.navigationController popViewControllerAnimated:YES];
         }
                                  Failure:^(AFHTTPRequestOperation * operation, NSError *error)
         {
             [self showErrorNotificationWithMessage:@"Danger is not saved"];
         }];
    }
}

- (IBAction)cancelDangerAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - GMTypeDangerViewControllerDelegate

- (void)userDidChooseTypeDanger:(GMTypeDanger *)typeDanger
{
    _typeDanger = typeDanger;
    [self updateTypeDangerBtn];
}

@end
