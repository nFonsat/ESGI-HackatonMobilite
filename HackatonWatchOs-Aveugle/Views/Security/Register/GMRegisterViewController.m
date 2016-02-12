//
//  GMRegisterViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 10/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMRegisterViewController.h"
#import "GMUserWebAPI.h"

@interface GMRegisterViewController ()
{
    @private
    GMUserWebAPI * _webUserManager;
    GMOAuth2Manager * _OAuth2Manager;
}

@property (weak, nonatomic) IBOutlet UITextField * usernameText;
@property (weak, nonatomic) IBOutlet UITextField * emailText;
@property (weak, nonatomic) IBOutlet UITextField * passwordText;
@property (weak, nonatomic) IBOutlet UITextField * confirmPasswordText;

- (IBAction)registerAction:(UIButton *)sender;
- (IBAction)goToLoginView:(UIButton *)sender;

@end

@implementation GMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webUserManager = [[GMUserWebAPI alloc] init];
    
    _OAuth2Manager = [[GMOAuth2Manager alloc] init];
}

#pragma mark - GMBaseViewController

- (UIColor *)getBarTintColor
{
    return [UIColor blackColor];
}

- (NSString *)getTitle
{
    return @"Sign up";
}

- (UIColor *)getTitleColor
{
    return [UIColor whiteColor];
}

#pragma mark - GMRegisterViewController Action

- (BOOL)formIsValid
{
    NSString * username = self.usernameText.text;
    NSString * email = self.emailText.text;
    NSString * password = self.passwordText.text;
    NSString * confirmPassword = self.confirmPasswordText.text;
    NSString * errorMsg = nil;
    
    if (username == nil || [username isEmpty]) {
        errorMsg = @"Username is not valid";
        return NO;
    }
    else if (email == nil || [email isEmpty] || ![email isEmailValid]) {
        errorMsg = @"Email is not valid";
        return NO;
    }
    else if (password == nil || [password isEmpty]) {
        errorMsg = @"Password is not valid";
        return NO;
    }
    else if (confirmPassword == nil || [confirmPassword isEmpty]) {
        errorMsg = @"Confirm password is not valid";
        return NO;
    }
    else if (![confirmPassword isEqualToString:password]) {
        errorMsg = @"The confirm password must match the password";
        return NO;
    }
    else if (password.length < 7) {
        errorMsg = @"The password is too short";
        return NO;
    }
    
    if (errorMsg != nil) {
        [self showErrorNotificationWithMessage:errorMsg];
    }
    
    return YES;
}

#pragma mark - GMRegisterViewController Action

- (IBAction)registerAction:(UIButton *)sender {
    if ([self formIsValid]) {
        [_webUserManager postUserWithEmail:self.emailText.text
                                 Username:self.usernameText.text
                                 Password:self.passwordText.text
                                  Success:^(id responseObject)
         {
             [_OAuth2Manager loginWithUsername:self.usernameText.text
                                     Password:self.passwordText.text
                                      Success:^(AFOAuthCredential * credential)
              {
                  [self login];
              }
                                      Failure:^(NSError * error)
              {
                  [self showErrorNotificationWithMessage:[NSString stringWithFormat:@"Error during authentication"]];
              }];
         }
                                  Failure:^(NSError *error)
         {
             [self showErrorNotificationWithMessage:[NSString stringWithFormat:@"Error during sign up"]];
         }];
    }
}

- (IBAction)goToLoginView:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
