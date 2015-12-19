//
//  AppDelegate.m
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "AppDelegate.h"
#import "GMMainViewController.h"
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSServices provideAPIKey:@"AIzaSyBlTArM1_K1_Eo6dYuRAWHvh_xqzN72hxs"];
    
    GMMainViewController * mainViewController = [GMMainViewController new];
    
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    navigationController.navigationBar.hidden = YES;
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIWindow * window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = navigationController;

    self.window = window;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
