//
//  GMLoginViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 10/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMLoginViewController.h"
#import "GMOAuth2Manager.h"
#import "GMRegisterViewController.h"
#import "GMMainVIewController.h"

@interface GMLoginViewController ()
{
@private
    GMOAuth2Manager * OAuth2Manager;
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
    OAuth2Manager = [[GMOAuth2Manager alloc] init];
}

- (IBAction)loginAction:(UIButton *)sender
{
    [OAuth2Manager loginWithUsername: self.usernameText.text
                            Password:self.passwordText.text
                             Success:^(AFOAuthCredential * credential)
     {
         GMMainViewController * mainView = [[GMMainViewController alloc] init];
         [self.navigationController pushViewController:mainView animated:YES];
     }
                             Failure:^(NSError * error)
     {
         NSLog(@"Error loginAction => %@", error);
     }];
}

- (IBAction)goToRegisterView:(UIButton *)sender
{
    GMRegisterViewController * registerViewController = [[GMRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

@end
