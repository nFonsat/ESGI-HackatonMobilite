//
//  GMDangerWebAPI.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 03/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMDangerWebAPI.h"

@implementation GMDangerWebAPI

- (instancetype)init
{
    return [self initWithBaseURL:@"/api/v1/danger"];
}

- (void)getTypeDangersSuccess:(void (^)(id responseObject))success
                      Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager GET:[NSString stringWithFormat:@"%@/types",self.baseURL]
                 parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(operation, error);
     }];
}

- (void)getDangersSuccess:(void (^)(id responseObject))success
                  Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager GET:[NSString stringWithFormat:@"%@/all",self.baseURL]
                 parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(operation, error);
     }];
}

- (void)getDangersFromCenter:(CLLocationCoordinate2D)centerCoordinate
                    Distance:(NSNumber *)distance
                     Success:(void (^)(id responseObject))success
                     Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure
{
    [self authenticateUserWithCredential];
    
    CLLocationDegrees latitude = centerCoordinate.latitude;
    CLLocationDegrees longitude = centerCoordinate.longitude;
    
    [self.OAuth2Manager GET:[NSString stringWithFormat:@"%@/all?latitude=%f&longitude=%f&distance=%ld", self.baseURL, latitude, longitude, distance.longValue]
                 parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(operation, error);
     }];
}

- (void)postDangerWithName:(NSString *)name
                Coordinate:(CLLocationCoordinate2D)coordinate
                      Type:(GMTypeDanger *)type
                   Success:(void (^)(id responseObject))success
                   Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure
{
    [self authenticateUserWithCredential];
    
    NSDictionary * parameters = @{
                                  @"name":name,
                                  @"latitude": @(coordinate.latitude),
                                  @"longitude": @(coordinate.longitude),
                                  @"typeId": type.typeDangerId,
                                  };
    
    
    [self.OAuth2Manager POST:self.baseURL
                  parameters:parameters
                     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(operation, error);
     }];
}

- (void)getDangerWithDangerId:(NSString *)dangerId
                      Success:(void (^)(id responseObject))success
                      Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager GET:[NSString stringWithFormat:@"%@/%@",self.baseURL, dangerId]
                 parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(operation, error);
     }];
}

- (void)updateDangerWithDangerId:(NSString *)dangerId
                         NewName:(NSString *)newName
                         NewType:(GMTypeDanger *)newType
                         Success:(void (^)(id responseObject))success
                         Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure
{
    [self authenticateUserWithCredential];
    
    NSDictionary * parameters = @{
                                  @"name":newName,
                                  @"typeId":newType.typeDangerId,
                                  };
    
    [self.OAuth2Manager PUT:[NSString stringWithFormat:@"%@/%@",self.baseURL, dangerId]
                 parameters:parameters
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(operation, error);
     }];
}

- (void)deleteDangerWithDangerId:(NSString *)dangerId
                         Success:(void (^)(id responseObject))success
                         Failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager DELETE:[NSString stringWithFormat:@"%@/%@",self.baseURL, dangerId]
                    parameters:nil
                       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(operation, error);
     }];
}

@end
