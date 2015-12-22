//
//  GMLocation.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMLocation.h"

@interface GMLocation ()

@end

@implementation GMLocation

@synthesize locationId = _locationId;
@synthesize name = _name;
@synthesize coordinate = _coordinate;

- (instancetype)initWithLocationId:(NSString *)locationId
                              Name:(NSString *)name
{
    if (self = [super init]) {
        _locationId = locationId;
        _name = name;
    }
    
    return self;
}

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

- (instancetype)initFromJsonDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        _locationId = [json objectForKey:@"_id"];
        _name = [json objectForKey:@"name"];
        
        NSDictionary * coordinateObject = [json objectForKey:@"coordonate"];
        NSArray<NSNumber *> * geometry = [coordinateObject objectForKey:@"geometry"];
        
        CLLocation * loc = [[CLLocation alloc] initWithLatitude:geometry[0].doubleValue longitude:geometry[1].doubleValue];
        
        _coordinate = loc.coordinate;
    }
    
    return self;
}

@end
