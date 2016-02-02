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

- (UIColor *)getBarTintColor
{
    return [UIColor blackColor];
}

- (NSString *)getTitle
{
    return @"Sign in";
}

- (UIColor *)getTitleColor
{
    return [UIColor whiteColor];
}

- (IBAction)loginAction:(UIButton *)sender
{
    NSString * username = self.usernameText.text;
    NSString * password = self.passwordText.text;
    
    if ([self formIsValid]) {
        [OAuth2Manager loginWithUsername:username
                                Password:password
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
    else {
        NSLog(@"Update form");
    }
    
    
}

- (IBAction)goToRegisterView:(UIButton *)sender
{
    GMRegisterViewController * registerViewController = [[GMRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (BOOL)formIsValid
{
    if ([self.usernameText.text isEqualToString:@""] || [self.passwordText.text isEqualToString:@""]) {
        return NO;
    }
    else {
        return YES;
    }
}

@end
