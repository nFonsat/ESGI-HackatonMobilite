//
//  GMWebAPI.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 17/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMOAuth2Manager.h"

@interface GMWebAPI : NSObject
{
    GMOAuth2Manager * _OAuth2Manager;
    NSString * _baseURL;
}

@property (readonly, nonatomic, strong) GMOAuth2Manager * OAuth2Manager;
@property (readonly, nonatomic, strong) NSString * baseURL;

- (instancetype)initWithBaseURL:(NSString *)base;

- (void) authenticateUserWithCredential;

@end
