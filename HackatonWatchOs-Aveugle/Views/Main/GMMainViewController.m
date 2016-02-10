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
#import "GMLocationHomeViewController.h"
#import "GMDangerViewController.h"

@interface GMMainViewController ()

- (IBAction)goToFavoriteListView:(UIButton *)sender;
- (IBAction)goToLocationView:(UIButton *)sender;
- (IBAction)goToDangerView:(UIButton *)sender;

@end

@implementation GMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)goToFavoriteListView:(UIButton *)sender
{
    GMFavoriteListViewController * favoriteView = [[GMFavoriteListViewController alloc] init];
    [self.navigationController pushViewController:favoriteView animated:YES];
}

- (IBAction)goToLocationView:(UIButton *)sender
{
    GMLocationHomeViewController * locationHomeView = [[GMLocationHomeViewController alloc] init];
    [self.navigationController pushViewController:locationHomeView animated:YES];
}

- (IBAction)goToDangerView:(UIButton *)sender
{
    GMDangerViewController * dangerView = [[GMDangerViewController alloc] init];
    [self.navigationController pushViewController:dangerView animated:YES];
}

@end
