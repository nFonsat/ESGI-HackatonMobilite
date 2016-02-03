//
//  GMLocationHomeViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMLocationHomeViewController.h"
#import "GMLocationAddViewController.h"
#import "GMLocationMapViewController.h"
#import "GMFavoriteListViewController.h"
#import "GMHistoriesViewController.h"

@interface GMLocationHomeViewController ()

- (IBAction)goToAddView:(UIButton *)sender;
- (IBAction)goToMapView:(UIButton *)sender;
- (IBAction)goToFavoriteView:(UIButton *)sender;
- (IBAction)goToHistoryView:(UIButton *)sender;

@end

@implementation GMLocationHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)goToAddView:(UIButton *)sender
{
    GMLocationAddViewController * locationAddView = [[GMLocationAddViewController alloc] init];
    [self.navigationController pushViewController:locationAddView animated:YES];
}

- (IBAction)goToMapView:(UIButton *)sender
{
    GMLocationMapViewController * locationMapView = [[GMLocationMapViewController alloc] init];
    [self.navigationController pushViewController:locationMapView animated:YES];
}

- (IBAction)goToFavoriteView:(UIButton *)sender
{
    GMFavoriteListViewController * favoriteView = [[GMFavoriteListViewController alloc] init];
    [self.navigationController pushViewController:favoriteView animated:YES];
}

- (IBAction)goToHistoryView:(UIButton *)sender
{
    GMHistoriesViewController * historyView = [[GMHistoriesViewController alloc] init];
    [self.navigationController pushViewController:historyView animated:YES];
}

@end
