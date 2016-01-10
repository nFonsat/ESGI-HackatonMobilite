//
//  GMLocationMapViewController.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMBaseViewController.h"
#import "GMLocation.h"

@import MapKit;
@import CoreLocation;

@interface GMLocationMapViewController : GMBaseViewController <MKMapViewDelegate, CLLocationManagerDelegate>

- (instancetype)initWithGMLocation:(GMLocation *)location;

@end
