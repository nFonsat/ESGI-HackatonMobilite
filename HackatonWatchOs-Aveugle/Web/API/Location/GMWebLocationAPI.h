//
//  GMWebLocationAPI.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "GMWebAPI.h"

@interface GMWebLocationAPI : GMWebAPI

- (void)getLocationsSuccess:(void (^)(id responseObject))success
                     Failure:(void (^)(NSError *error))failure;

- (void)getFavoritesSuccess:(void (^)(id responseObject))success
                    Failure:(void (^)(NSError *error))failure;

- (void)getHistoriesSuccess:(void (^)(id responseObject))success
                    Failure:(void (^)(NSError *error))failure;

- (void)postLocationWithName:(NSString *)name
                     Location:(CLLocation *)location
                      Success:(void (^)(id responseObject))success
                      Failure:(void (^)(NSError *error))failure;

- (void)getLocationWithLocationId:(NSString *)locationId
                           Success:(void (^)(id responseObject))success
                           Failure:(void (^)(NSError *error))failure;

- (void)updateLocationWithLocationId:(NSString *)locationId
                              NewName:(NSString *)newName
                              Success:(void (^)(id responseObject))success
                              Failure:(void (^)(NSError *error))failure;

- (void)deleteLocationWithLocationId:(NSString *)locationId
                              Success:(void (^)(id responseObject))success
                              Failure:(void (^)(NSError *error))failure;

- (void)playLocation:(NSString *)locationId
             Success:(void (^)(id responseObject))success
             Failure:(void (^)(NSError *error))failure;

- (void)postNewLocationWithName:(NSString *)name
                    Location:(CLLocation *)location
                     Success:(void (^)(id responseObject))success
                     Failure:(void (^)(NSError *error))failure;

- (void)postFavoriteLocation:(NSString *)locationId
                     Success:(void (^)(id responseObject))success
                     Failure:(void (^)(NSError *error))failure;

- (void)deleteFavoriteLocation:(NSString *)locationId
                       Success:(void (^)(id responseObject))success
                       Failure:(void (^)(NSError *error))failure;

@end
