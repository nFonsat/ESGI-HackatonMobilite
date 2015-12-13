//
//  GMMainViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 09/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMMainViewController.h"
#import "GMOAuthManager.h"
#import "GMLoginViewController.h"

@interface GMMainViewController ()

@end

@implementation GMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Guid'me";
}

- (void)viewDidAppear:(BOOL)animated
{
    AFOAuthCredential *credential =
    [AFOAuthCredential retrieveCredentialWithIdentifier:OAUTH_CLIENT];
    
    if (credential == nil) {
        GMLoginViewController * loginView = [[GMLoginViewController alloc] init];
        [self.navigationController pushViewController:loginView animated:YES];
    }
}

@end
