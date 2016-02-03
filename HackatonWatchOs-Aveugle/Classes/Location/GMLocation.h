//
//  GMLocation.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import <Foundation/Foundation.h>

@interface GMLocation : NSObject
{
    NSString * _locationId;
    NSString * _name;
    NSDate * _lastUsed;
    NSNumber * _navigateTo;
    CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, strong) NSString * locationId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSDate * lastUsed;
@property (nonatomic, strong) NSNumber * navigateTo;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (instancetype)initWithLocationId:(NSString *)locationId
                              Name:(NSString *)name;

- (instancetype)initWithLocationId:(NSString *)locationId
                              Name:(NSString *)name
                        Coordinate:(CLLocationCoordinate2D)coordinate;

- (instancetype)initFromJsonDictionary:(NSDictionary *)json;

@end
