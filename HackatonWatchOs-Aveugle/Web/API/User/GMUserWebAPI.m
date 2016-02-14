//
//  GMWebUserAPI.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 17/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMUserWebAPI.h"

@implementation GMUserWebAPI

+ (instancetype)sharedUserWebAPI
{
    static GMUserWebAPI * sharedUserWebAPI = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedUserWebAPI = [[self alloc] init];
    });
    
    return sharedUserWebAPI;
}

- (instancetype)init
{
    return [super initWithBaseURL:@"/api/v1/user"];
}

- (void) getUserWithSuccess:(void (^)(id responseObject))success
                    Failure:(void (^)(NSError *error))failure
{
    [self authenticateUserWithCredential];
    [self.OAuth2Manager GET:self.baseURL
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

- (void) postUserWithEmail:(NSString *)email
                  Username:(NSString *)username
                  Password:(NSString *)password
                   Success:(void (^)(id responseObject))success
                   Failure:(void (^)(NSError *error))failure
{
    NSDictionary * parameters = @{
                                  @"email": email,
                                  @"username": username,
                                  @"password": password,
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

@end
