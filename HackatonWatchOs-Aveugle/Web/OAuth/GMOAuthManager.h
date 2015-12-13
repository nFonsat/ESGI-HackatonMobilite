//
//  GMOAuthManager.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 13/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFOAuth2Manager.h"

#define OAUTH_CLIENT    @"guid_me_ios"
#define OAUTH_PASSWORD  @"fraf_uzEch@g5Guh"
#define OAUTH_URL       @"http://95.85.51.133/oauth/token"

@protocol GMOAuthManagerDelegate <NSObject>

- (void)oauthTokenSuccess:(id)object;
- (void)oauthTokenError:(NSError *)error;

@end

@interface GMOAuthManager : NSObject {
    id <GMOAuthManagerDelegate> _delegate;
}

@property (nonatomic, retain) id <GMOAuthManagerDelegate> delegate;

+ (id)sharedManager;

- (void)getAccessTokenWithUsername:(NSString *)username
                       AndPassword:(NSString *)password;

- (void)getRefreshTokenFromCredential:(AFOAuthCredential *)credential;

@end

