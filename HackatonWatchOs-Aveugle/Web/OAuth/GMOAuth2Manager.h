//
//  GMOAuth2Manager.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 15/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>

#define OAUTH_CLIENT    @"guid_me_ios"
#define OAUTH_PASSWORD  @"fraf_uzEch@g5Guh"

@interface GMOAuth2Manager : AFOAuth2Manager

- (instancetype)init;

- (void)getAccessTokenWithUsername:(NSString *)username
                          Password:(NSString *)password
                           Success:(void (^)(AFOAuthCredential *credential))success
                           Failure:(void (^)(NSError *error))failure;

- (void)getRefreshTokenSuccess:(void (^)(AFOAuthCredential *credential))success
                       Failure:(void (^)(NSError *error))failure;

@end
