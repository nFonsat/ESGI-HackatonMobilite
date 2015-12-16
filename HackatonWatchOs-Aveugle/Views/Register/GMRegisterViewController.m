//
//  GMRegisterViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 10/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMRegisterViewController.h"
#import "GMLoginViewController.h"
#import "AFNetworking.h"

@interface GMRegisterViewController ()

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
}

- (IBAction)registerAction:(UIButton *)sender {    
    if (![self.passwordText.text isEqual: self.confirmPasswordText.text]) {
        NSLog(@"Problème password : %@ != %@", self.passwordText.text, self.confirmPasswordText.text);
        return;
    }
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{
                                 @"email": self.emailText.text,
                                 @"username": self.usernameText.text,
                                 @"password": self.passwordText.text,
                                 };
    
    [manager POST:@"http://95.85.51.133/api/v1/user"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
     ];
}

- (IBAction)goToLoginView:(UIButton *)sender {
    GMLoginViewController * loginViewController = [[GMLoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

@end
