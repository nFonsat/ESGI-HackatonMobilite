//
//  GMRegisterViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 10/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMRegisterViewController.h"
#import "GMLoginViewController.h"
#import "GMWebUserAPI.h"

@interface GMRegisterViewController ()
{
    @private
    GMWebUserAPI * webUserManager;
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
}

- (IBAction)registerAction:(UIButton *)sender {    
    if (![self.passwordText.text isEqual: self.confirmPasswordText.text]) {
        NSLog(@"Problème password : %@ != %@", self.passwordText.text, self.confirmPasswordText.text);
        return;
    }
    
    [webUserManager postUserWithEmail:self.emailText.text
                             Username:self.usernameText.text
                             Password:self.passwordText.text
                              Success:^(id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
     }
                              Failure:^(NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

- (IBAction)goToLoginView:(UIButton *)sender {
    GMLoginViewController * loginViewController = [[GMLoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

@end
