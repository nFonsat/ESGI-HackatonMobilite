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
#import "GMLocationHomeViewController.h"

@interface GMMainViewController ()
{
    @private
    GMWebUserAPI * webUserManager;
}

- (IBAction)goToLocationView:(UIButton *)sender;
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

- (IBAction)goToLocationView:(UIButton *)sender
{
    GMLocationHomeViewController * locationHomeView = [[GMLocationHomeViewController alloc] init];
    [self.navigationController pushViewController:locationHomeView animated:YES];
}

@end
