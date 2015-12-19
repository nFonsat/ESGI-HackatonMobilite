//
//  GMLocation.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMLocation.h"

@implementation GMLocation

@synthesize locationId = _locationId;
@synthesize name = _name;
@synthesize coordonate = _coordonate;
@synthesize isGooglePlace = _isGooglePlace;

- (instancetype)initWithLocationId:(NSString *)locationId
                              Name:(NSString *)name
                        Coordonate:(CLLocation *)coordonate
                     isGooglePlace:(BOOL)isGooglePlace
{
    if (self = [super init]) {
        _locationId = locationId;
        _name = name;
        _coordonate = coordonate;
        _isGooglePlace = isGooglePlace;
    }
    
    return self;
}

- (instancetype)initWithLocationId:(NSString *)locationId
                              Name:(NSString *)name
                     isGooglePlace:(BOOL)isGooglePlace
{
    if (self = [super init]) {
        _locationId = locationId;
        _name = name;
        _isGooglePlace = isGooglePlace;
    }
    
    return self;
}

@end
