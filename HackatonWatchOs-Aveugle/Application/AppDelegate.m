//
//  AppDelegate.m
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "AppDelegate.h"
#import "GMMainViewController.h"
#import "GMNavigationController.h"
#import "GMUserWebAPI.h"
#import "GMLoginViewController.h"
@import GoogleMaps;

@interface AppDelegate ()

@property(nonatomic, strong) GMUserWebAPI * webUserManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GMSServices provideAPIKey:@"AIzaSyBlTArM1_K1_Eo6dYuRAWHvh_xqzN72hxs"];
    
    _webUserManager = [[GMUserWebAPI alloc] init];
    
    [_webUserManager getUserWithSuccess:^(id responseObject)
     {
         GMMainViewController * mainViewController = [GMMainViewController new];
         [self application:application withRootViewController:mainViewController];
     }
                               Failure:^(NSError *error)
     {
         GMLoginViewController * loginView = [GMLoginViewController new];
         [self application:application withRootViewController:loginView];
     }];
    
    return YES;
}

- (void)application:(UIApplication *)application withRootViewController:(UIViewController *)rootViewController
{
    GMNavigationController * navigationController = [[GMNavigationController alloc] initWithRootViewController:rootViewController];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIWindow * window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = navigationController;
    
    self.window = window;
    [self.window makeKeyAndVisible];
}

@end
