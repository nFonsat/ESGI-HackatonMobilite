//
//  GMMainViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 09/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <AFOAuth2Manager/AFOAuth2Manager.h>

#import "GMMainViewController.h"
#import "GMOAuth2Manager.h"
#import "GMLoginViewController.h"

@interface GMMainViewController ()
{
    @private
    GMOAuth2Manager * OAuth2Manager;
}

@end

@implementation GMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OAuth2Manager = [[GMOAuth2Manager alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    AFOAuthCredential *credential =
    [AFOAuthCredential retrieveCredentialWithIdentifier:OAUTH_CLIENT];
    
    if ([credential.tokenType compare:@"Bearer" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        [OAuth2Manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", credential.accessToken]
                               forHTTPHeaderField:@"Authorization"];
    }
    
    [OAuth2Manager GET:@"/api/v1/user"
            parameters:nil
               success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Success: %@", responseObject);
    }
               failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        GMLoginViewController * loginView = [[GMLoginViewController alloc] init];
        [self.navigationController pushViewController:loginView animated:YES];
    }];
}

@end
