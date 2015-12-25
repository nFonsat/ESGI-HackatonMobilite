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
#import "GMFavoriteListViewController.h"

@interface GMMainViewController ()
{
    @private
    GMWebUserAPI * webUserManager;
}

- (IBAction)goToFavoriteListView:(UIButton *)sender;
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

- (IBAction)goToFavoriteListView:(UIButton *)sender
{
    GMFavoriteListViewController * favoriteView = [[GMFavoriteListViewController alloc] init];
    [self.navigationController pushViewController:favoriteView animated:YES];
}

@end
