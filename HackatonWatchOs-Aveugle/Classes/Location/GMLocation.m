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
@synthesize coordinate = _coordinate;

- (instancetype)initWithLocationId:(NSString *)locationId
                              Name:(NSString *)name
                        Coordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init]) {
        _locationId = locationId;
        _name = name;
        _coordinate = coordinate;
    }
    
    return self;
}

- (instancetype)initWithLocationId:(NSString *)locationId
                              Name:(NSString *)name
{
    if (self = [super init]) {
        _locationId = locationId;
        _name = name;
    }
    
    return self;
}

@end
