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
    CLLocation * _coordonate;
    BOOL _isGooglePlace;
}

@property (nonatomic, strong) NSString * locationId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) CLLocation * coordonate;
@property (nonatomic, assign, readonly) BOOL isGooglePlace;

- (instancetype)initWithLocationId:(NSString *)locationId
                              Name:(NSString *)name
                        Coordonate:(CLLocation *)coordonate
                     isGooglePlace:(BOOL)isGooglePlace;

- (instancetype)initWithLocationId:(NSString *)locationId
                              Name:(NSString *)name
                     isGooglePlace:(BOOL)isGooglePlace;

@end
