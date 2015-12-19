//
//  GMLocationHomeViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMLocationHomeViewController.h"
#import "GMLocationAddViewController.h"

@interface GMLocationHomeViewController ()

- (IBAction)goToAddView:(UIButton *)sender;
@end

@implementation GMLocationHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)goToAddView:(UIButton *)sender
{
    GMLocationAddViewController * locationAddView = [[GMLocationAddViewController alloc] init];
    [self.navigationController pushViewController:locationAddView animated:YES];
}
@end
