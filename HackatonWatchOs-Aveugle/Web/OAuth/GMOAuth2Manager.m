//
//  GMOAuth2Manager.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 15/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMOAuth2Manager.h"

@implementation GMOAuth2Manager
{
    @private
}

- (instancetype)init
{
    NSURL * baseURL = [NSURL URLWithString:@"http://95.85.51.133"];
    return [super initWithBaseURL:baseURL clientID:OAUTH_CLIENT secret:OAUTH_PASSWORD];
}


- (void)getAccessTokenWithUsername:(NSString *)username
                          Password:(NSString *)password
                           Success:(void (^)(AFOAuthCredential *credential))success
                           Failure:(void (^)(NSError *error))failure
{
    [self authenticateUsingOAuthWithURLString:@"/oauth/token"
                                              username:username
                                              password:password
                                                 scope:@""
                                               success:^(AFOAuthCredential *credential) {
                                                   [AFOAuthCredential storeCredential:credential
                                                                       withIdentifier:OAUTH_CLIENT];
                                                   
                                                   //NSLog(@"Token: %@", credential.accessToken);
                                                   success(credential);
                                               }
                                               failure:^(NSError *error) {
                                                   failure(error);
                                                   NSLog(@"Error: %@", error);
                                               }];
}

- (void)getRefreshTokenSuccess:(void (^)(AFOAuthCredential *credential))success
                       Failure:(void (^)(NSError *error))failure
{
    AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier:OAUTH_CLIENT];
    
    [self authenticateUsingOAuthWithURLString:@"/oauth/token"
                                          refreshToken:credential.refreshToken
                                               success:^(AFOAuthCredential *credential) {
                                                   [AFOAuthCredential storeCredential:credential
                                                                       withIdentifier:OAUTH_CLIENT];
                                                   
                                                   //NSLog(@"Token: %@", credential.accessToken);
                                                   success(credential);
                                               }
                                               failure:^(NSError *error) {
                                                   failure(error);
                                                   NSLog(@"Error: %@", error);
                                               }];
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    return [self HTTPRequestOperationWithRequest:request success:success failure:failure checkIfTokenIsExpired:YES];
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                                      checkIfTokenIsExpired:(BOOL) checkIfTokenIsExpired
{
    if (!checkIfTokenIsExpired)
    {
        return [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    }
    else
    {
        return [super HTTPRequestOperationWithRequest:request
                                              success:success
                                              failure:^(AFHTTPRequestOperation *operation, NSError *error)
                {
                    NSLog(@"Request return statusCode = %ld", operation.response.statusCode);
                    NSLog(@"Request return JSON = %@", operation.responseObject);
                    if (operation.response.statusCode == 401)
                    {
                        [self getRefreshTokenSuccess:^(AFOAuthCredential *credential)
                         {
                             AFHTTPRequestOperation *moperation = [self HTTPRequestOperationWithRequest:request
                                                                                                success:success
                                                                                                failure:failure
                                                                                  checkIfTokenIsExpired:NO];
                             [self.operationQueue addOperation:moperation];
                         }
                                             Failure:^(NSError *error)
                         {
                             failure(nil, error);
                         }];
                    }
                    else
                    {
                        failure(operation, error);
                    }
                }];
        
    }
}

@end
