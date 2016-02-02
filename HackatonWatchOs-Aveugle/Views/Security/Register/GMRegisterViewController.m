//
//  GMRegisterViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 10/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMRegisterViewController.h"
#import "GMMainVIewController.h"
#import "GMWebUserAPI.h"

@interface GMRegisterViewController ()
{
    @private
    GMWebUserAPI * webUserManager;
    GMOAuth2Manager * OAuth2Manager;
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
    
    webUserManager = [[GMWebUserAPI alloc] init];
    
    OAuth2Manager = [[GMOAuth2Manager alloc] init];
}

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

- (IBAction)registerAction:(UIButton *)sender {
    if ([self formIsValid]) {
        [webUserManager postUserWithEmail:self.emailText.text
                                 Username:self.usernameText.text
                                 Password:self.passwordText.text
                                  Success:^(id responseObject)
         {
             [OAuth2Manager loginWithUsername:self.usernameText.text
                                     Password:self.passwordText.text
                                      Success:^(AFOAuthCredential * credential)
              {
                  GMMainViewController * mainView = [[GMMainViewController alloc] init];
                  [self.navigationController setViewControllers:@[mainView] animated:YES];
              }
                                      Failure:^(NSError * error)
              {
                  NSLog(@"Error loginAction => %@", error);
              }];
         }
                                  Failure:^(NSError *error)
         {
             NSLog(@"Error: %@", error);
         }];
    }
    else {
        NSLog(@"Update form");
    }
}

- (IBAction)goToLoginView:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)formIsValid
{
    if ([self.usernameText.text isEqualToString:@""] || [self.emailText.text isEqualToString:@""]
        || [self.passwordText.text isEqualToString:@""]|| [self.confirmPasswordText.text isEqualToString:@""]) {
        return NO;
    }
    else if (![self.passwordText.text isEqual: self.confirmPasswordText.text]) {
        NSLog(@"Problème password : %@ != %@", self.passwordText.text, self.confirmPasswordText.text);
        return NO;
    }
    else {
        return YES;
    }
}

@end
