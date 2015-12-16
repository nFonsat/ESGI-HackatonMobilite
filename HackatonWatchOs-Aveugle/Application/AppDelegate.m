//
//  AppDelegate.m
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "AppDelegate.h"
#import "GMMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    GMMainViewController * mainViewController = [GMMainViewController new];
    
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    navigationController.navigationBar.hidden = YES;
    
    UIWindow * window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = navigationController;

    self.window = window;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
