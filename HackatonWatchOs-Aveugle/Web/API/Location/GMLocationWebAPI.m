//
//  GMWebLocationAPI.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMLocationWebAPI.h"

@implementation GMLocationWebAPI

+ (instancetype)sharedLocationWebAPI
{
    static GMLocationWebAPI * sharedLocationWebAPI = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedLocationWebAPI = [[self alloc] init];
    });
    
    return sharedLocationWebAPI;
}

- (instancetype)init
{
    return [self initWithBaseURL:@"/api/v1/location"];
}

- (void)getLocationsSuccess:(void (^)(id responseObject))success
                     Failure:(void (^)(NSError *error))failure
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
         failure(error);
     }];
}

- (void)getFavoritesSuccess:(void (^)(id responseObject))success
                    Failure:(void (^)(NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager GET:[NSString stringWithFormat:@"%@/all?favorite",self.baseURL]
                 parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

- (void)getHistoriesSuccess:(void (^)(id responseObject))success
                    Failure:(void (^)(NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager GET:[NSString stringWithFormat:@"%@/all?history",self.baseURL]
                 parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

- (void)postLocationWithName:(NSString *)name
                     Location:(CLLocation *)location
                      Success:(void (^)(id responseObject))success
                      Failure:(void (^)(NSError *error))failure
{
    [self authenticateUserWithCredential];
    
    NSDictionary * parameters = @{
                                  @"name":name,
                                  @"latitude": @(location.coordinate.latitude),
                                  @"longitude": @(location.coordinate.longitude),
                                  };
    
    
    [self.OAuth2Manager POST:self.baseURL
                 parameters:parameters
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

- (void)getLocationWithLocationId:(NSString *)locationId
                           Success:(void (^)(id responseObject))success
                           Failure:(void (^)(NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager GET:[NSString stringWithFormat:@"%@/%@",self.baseURL, locationId]
                 parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

- (void)updateLocationWithLocationId:(NSString *)locationId
                              NewName:(NSString *)newName
                              Success:(void (^)(id responseObject))success
                              Failure:(void (^)(NSError *error))failure
{
    [self authenticateUserWithCredential];
    
    NSDictionary * parameters = @{
                                  @"name":newName,
                                  };
    
    [self.OAuth2Manager PUT:[NSString stringWithFormat:@"%@/%@",self.baseURL, locationId]
                 parameters:parameters
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}


- (void)deleteLocationWithLocationId:(NSString *)locationId
                              Success:(void (^)(id responseObject))success
                              Failure:(void (^)(NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager DELETE:[NSString stringWithFormat:@"%@/%@",self.baseURL, locationId]
                    parameters:nil
                       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

- (void)playLocation:(NSString *)locationId
             Success:(void (^)(id responseObject))success
             Failure:(void (^)(NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager POST:[NSString stringWithFormat:@"%@/play/%@",self.baseURL, locationId]
                    parameters:nil
                       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}
- (void)postNewLocationWithName:(NSString *)name
                       Location:(CLLocation *)location
                        Success:(void (^)(id responseObject))success
                        Failure:(void (^)(NSError *error))failure
{
    [self authenticateUserWithCredential];
    
    NSDictionary * parameters = @{
                                  @"name":name,
                                  @"latitude": @(location.coordinate.latitude),
                                  @"longitude": @(location.coordinate.longitude),
                                  @"isfavorite": @YES,
                                  };
    
    
    [self.OAuth2Manager POST:self.baseURL
                  parameters:parameters
                     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

- (void)postFavoriteLocation:(NSString *)locationId
                     Success:(void (^)(id responseObject))success
                     Failure:(void (^)(NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager POST:[NSString stringWithFormat:@"%@/favorite/%@",self.baseURL, locationId]
                    parameters:nil
                       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

- (void)deleteFavoriteLocation:(NSString *)locationId
                       Success:(void (^)(id responseObject))success
                       Failure:(void (^)(NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager DELETE:[NSString stringWithFormat:@"%@/favorite/%@",self.baseURL, locationId]
                    parameters:nil
                       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}

@end
