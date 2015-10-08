//
//  ViewController.h
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "IAddressRepository.h"
#import "ITripRepository.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, readonly) id<IAddressRepository> addressRepository;
@property (nonatomic, readonly) id<ITripRepository> tripRepository;

@end

