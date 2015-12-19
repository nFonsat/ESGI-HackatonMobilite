//
//  GMMainViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 09/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMMainViewController.h"
#import "GMWebUserAPI.h"
#import "GMLoginViewController.h"

@interface GMMainViewController ()
{
    @private
    GMWebUserAPI * webUserManager;
}

@end

@implementation GMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    webUserManager = [[GMWebUserAPI alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
     [webUserManager getUserWithSuccess:^(id responseObject)
      {
          NSLog(@"Success: %@", responseObject);
      }
                                Failure:^(NSError *error)
      {
          GMLoginViewController * loginView = [[GMLoginViewController alloc] init];
          [self.navigationController pushViewController:loginView animated:YES];
      }];
}

@end
