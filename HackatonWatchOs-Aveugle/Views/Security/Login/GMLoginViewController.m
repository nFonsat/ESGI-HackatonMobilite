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

@interface GMLoginViewController ()
{
@private
    GMOAuth2Manager * _OAuth2Manager;
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
    _OAuth2Manager = [[GMOAuth2Manager alloc] init];
}

#pragma mark - GMBaseViewController

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

#pragma mark - GMLoginViewController Helper UI

- (BOOL)formIsValid
{
    NSString * username = self.usernameText.text;
    NSString * password = self.passwordText.text;
    NSString * errorMsg = nil;
    
    if (username == nil || [username isEmpty]) {
        errorMsg = @"Username is not valid";
    }
    else if (password == nil || [password isEmpty]) {
        errorMsg = @"Password is not valid";
    }
    
    if (errorMsg != nil) {
        [self showErrorNotificationWithMessage:errorMsg];
    }
    
    return errorMsg == nil;
}

#pragma mark - GMLoginViewController Action

- (IBAction)loginAction:(UIButton *)sender
{
    NSString * username = self.usernameText.text;
    NSString * password = self.passwordText.text;
    
    if ([self formIsValid]) {
        [_OAuth2Manager loginWithUsername:username
                                Password:password
                                 Success:^(AFOAuthCredential * credential)
         {
             [self login];
         }
                                 Failure:^(NSError * error)
         {
             [self showErrorNotificationWithMessage:@"Username/Password is not valid"];
         }];
    }
    
    
}

- (IBAction)goToRegisterView:(UIButton *)sender
{
    GMRegisterViewController * registerViewController = [[GMRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

@end
