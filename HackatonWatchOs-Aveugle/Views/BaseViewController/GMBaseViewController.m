//
//  GMBaseViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 09/01/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMBaseViewController.h"

@interface GMBaseViewController ()

- (UIColor *)getBarTintColor;

- (UIColor *)getTintColor;

- (NSString *)getTitle;

- (UIColor *)getTitleColor;

@end

@implementation GMBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:[self getTitle]];
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"";
    [self.navigationController.navigationBar.topItem setBackBarButtonItem:backButton];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [self getTitleColor]}];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBarTintColor:[self getBarTintColor]];
    [self.navigationController.navigationBar setTintColor:[self getTintColor]];
    
    [super viewWillAppear:animated];
}

- (UIColor *)getBarTintColor
{
    return [UIColor blackColor];
}

- (UIColor *)getTintColor
{
    return [UIColor whiteColor];
}

- (NSString *)getTitle
{
    return @"";
}

- (UIColor *)getTitleColor
{
    return [UIColor whiteColor];
}

@end
