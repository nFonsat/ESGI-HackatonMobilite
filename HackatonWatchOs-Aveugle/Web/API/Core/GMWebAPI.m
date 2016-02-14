//
//  GMWebAPI.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 17/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMWebAPI.h"

@implementation GMWebAPI

@synthesize OAuth2Manager = _OAuth2Manager;
@synthesize baseURL = _baseURL;

- (instancetype)initWithBaseURL:(NSString *)base;
{
    if (self = [super init]) {
        _baseURL = base;
       _OAuth2Manager = [GMOAuth2Manager sharedOAuth2Manager];
    }
    
    return self;
}

- (void)authenticateUserWithCredential
{
    AFOAuthCredential *credential =
    [AFOAuthCredential retrieveCredentialWithIdentifier:OAUTH_CLIENT];
    
    if ([credential.tokenType compare:@"Bearer" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        [_OAuth2Manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", credential.accessToken]
                               forHTTPHeaderField:@"Authorization"];
    }
}

@end
