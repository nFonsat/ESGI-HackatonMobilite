//
//  GMOAuthManager.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 13/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMOAuthManager.h"

@implementation GMOAuthManager

@synthesize delegate = _delegate;

+ (id)sharedManager {
    static GMOAuthManager * sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}

- (NSString *) createBasicAuthorizationString
{
    NSString * plainAuthorization = [NSString stringWithFormat:@"%@:%@", OAUTH_CLIENT, OAUTH_PASSWORD];
    
    NSData * dataBase64 = [plainAuthorization dataUsingEncoding:NSUTF8StringEncoding];
    NSString * stringBase64 = [dataBase64 base64EncodedStringWithOptions:0];
    
    return [NSString stringWithFormat:@"Basic %@", stringBase64];
}

- (void)getAccessTokenWithUsername:(NSString *)username
                                            AndPassword:(NSString *)password
{
    NSURL *baseURL = [NSURL URLWithString:@"http://95.85.51.133"];
    
    AFOAuth2Manager *OAuth2Manager =
    [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
                                    clientID:OAUTH_CLIENT
                                      secret:OAUTH_PASSWORD];
    
    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/oauth/token"
                                              username:username
                                              password:password
                                                 scope:@""
                                               success:^(AFOAuthCredential *credential) {
                                                   [AFOAuthCredential storeCredential:credential
                                                                       withIdentifier:OAUTH_CLIENT];
                                                   
                                                   //NSLog(@"Token: %@", credential.accessToken);
                                                   [self.delegate oauthTokenSuccess:credential];
                                               }
                                               failure:^(NSError *error) {
                                                   [self.delegate oauthTokenError:error];
                                                   NSLog(@"Error: %@", error);
                                               }];
}

- (void)getRefreshTokenFromCredential:(AFOAuthCredential *)credential
{
    NSURL *baseURL = [NSURL URLWithString:@"http://95.85.51.133"];
    
    AFOAuth2Manager *OAuth2Manager =
    [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
                                    clientID:OAUTH_CLIENT
                                      secret:OAUTH_PASSWORD];
    
    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/oauth/token"
                                          refreshToken:credential.refreshToken
                                               success:^(AFOAuthCredential *credential) {
                                                   [AFOAuthCredential storeCredential:credential
                                                                       withIdentifier:OAUTH_CLIENT];
                                                   
                                                   //NSLog(@"Token: %@", credential.accessToken);
                                                   [self.delegate oauthTokenSuccess:credential];
                                               }
                                               failure:^(NSError *error) {
                                                   [self.delegate oauthTokenError:error];
                                                   NSLog(@"Error: %@", error);
                                               }];
}

@end