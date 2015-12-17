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
#import "GMFavoriteListViewController.h"

@interface GMMainViewController ()
{
    @private
    GMOAuth2Manager * OAuth2Manager;
}

- (IBAction)goToFavoriteListView:(UIButton *)sender;
@end

@implementation GMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OAuth2Manager = [[GMOAuth2Manager alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    
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

- (IBAction)goToFavoriteListView:(UIButton *)sender
{
    GMFavoriteListViewController * favoriteView = [[GMFavoriteListViewController alloc] init];
    [self.navigationController pushViewController:favoriteView animated:YES];
}

@end
