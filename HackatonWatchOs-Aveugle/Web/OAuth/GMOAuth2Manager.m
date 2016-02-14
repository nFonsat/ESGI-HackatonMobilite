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


+ (instancetype)sharedOAuth2Manager
{
    static GMOAuth2Manager * sharedOAuth2Manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedOAuth2Manager = [[self alloc] init];
    });
    
    return sharedOAuth2Manager;
}


- (instancetype)init
{
    NSURL * baseURL = [NSURL URLWithString:@"http://95.85.51.133"];
    return [super initWithBaseURL:baseURL clientID:OAUTH_CLIENT secret:OAUTH_PASSWORD];
}

- (void)loginWithUsername:(NSString *)username
                 Password:(NSString *)password
                  Success:(void (^)(AFOAuthCredential *credential))success
                  Failure:(void (^)(NSError *error))failure
{
    [self authenticateUsingOAuthWithURLString:OAUTH_URL
                                     username:username
                                     password:password
                                        scope:@""
                                      success:^(AFOAuthCredential *credential)
     {
         [AFOAuthCredential storeCredential:credential
                             withIdentifier:OAUTH_CLIENT];
         success(credential);
     }
                                      failure:^(NSError *error)
     {
         failure(error);
     }];
}

- (void)refreshTokenSuccess:(void (^)(AFOAuthCredential *credential))success
                    Failure:(void (^)(NSError *error))failure
{
    [self setUseHTTPBasicAuthentication:YES];
    AFOAuthCredential * credential = [AFOAuthCredential retrieveCredentialWithIdentifier:OAUTH_CLIENT];
    if (credential == nil) {
        failure(nil);
        return;
    }
    
    [self authenticateUsingOAuthWithURLString:OAUTH_URL
                                 refreshToken:credential.refreshToken
                                      success:^(AFOAuthCredential *credential)
     {
         [AFOAuthCredential storeCredential:credential
                             withIdentifier:OAUTH_CLIENT];
         success(credential);
     }
                                      failure:^(NSError *error)
     {
         failure(error);
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
                    if (operation.response.statusCode == 401)
                    {
                        [self refreshTokenSuccess:^(AFOAuthCredential *credential)
                         {
                             NSURLRequest * requestForNewOperation = [self requestByAddingHeadersToRequest:request
                                                                                                Credential:credential];
                             
                             AFHTTPRequestOperation * moperation = [self HTTPRequestOperationWithRequest:requestForNewOperation
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

- (NSURLRequest *)requestByAddingHeadersToRequest:(NSURLRequest *)request Credential:(AFOAuthCredential *) credential
{
    NSURL * url = request.URL;
    NSMutableURLRequest * requestToReturn = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [requestToReturn setAllHTTPHeaderFields:request.allHTTPHeaderFields];
    
    NSString * headerValue = [NSString stringWithFormat:@"Bearer %@", credential.accessToken];
    [requestToReturn setValue:headerValue forHTTPHeaderField:@"Authorization"];
    
    
    return  requestToReturn;
}

@end
