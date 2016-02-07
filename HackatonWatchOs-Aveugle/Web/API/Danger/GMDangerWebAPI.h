//
//  GMDangerWebAPI.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 03/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "GMWebAPI.h"
#import "GMTypeDanger.h"

@interface GMDangerWebAPI : GMWebAPI

- (void)getTypeDangersSuccess:(void (^)(id responseObject))success
                  Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure;

- (void)getDangersSuccess:(void (^)(id responseObject))success
                  Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure;

- (void)getDangersFromCenter:(CLLocationCoordinate2D)centerCoordinate
                      Distance:(NSNumber *)distance
                     Success:(void (^)(id responseObject))success
                     Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure;

- (void)postDangerWithName:(NSString *)name
                Coordinate:(CLLocationCoordinate2D)coordinate
                      Type:(GMTypeDanger *)type
                   Success:(void (^)(id responseObject))success
                   Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure;

- (void)getDangerWithDangerId:(NSString *)dangerId
                      Success:(void (^)(id responseObject))success
                      Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure;

- (void)updateDangerWithDangerId:(NSString *)dangerId
                         NewName:(NSString *)newName
                         NewType:(GMTypeDanger *)newType
                         Success:(void (^)(id responseObject))success
                         Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure;

- (void)deleteDangerWithDangerId:(NSString *)dangerId
                         Success:(void (^)(id responseObject))success
                         Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure;

@end
