//
//  GMLoginViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 10/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMLoginViewController.h"
#import "GMRegisterViewController.h"
#import "GMMainVIewController.h"

@interface GMLoginViewController ()
{
    @private
    GMOAuthManager * manager;
}

@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)goToRegisterView:(UIButton *)sender;

@end

@implementation GMLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    manager = [GMOAuthManager sharedManager];
    manager.delegate = self;
}

- (IBAction)loginAction:(UIButton *)sender
{
    [manager getAccessTokenWithUsername:self.usernameText.text AndPassword:self.passwordText.text];
}

- (IBAction)goToRegisterView:(UIButton *)sender
{
    GMRegisterViewController * registerViewController = [[GMRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)oauthTokenSuccess:(id)object
{
    GMMainViewController * mainView = [[GMMainViewController alloc] init];
    [self.navigationController pushViewController:mainView animated:YES];
}

- (void)oauthTokenError:(NSError *)error
{
    NSLog(@"Error loginAction => %@", error);
}

@end
