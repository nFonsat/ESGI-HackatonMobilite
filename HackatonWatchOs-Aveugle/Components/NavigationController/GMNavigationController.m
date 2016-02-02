//
//  GMNavigationController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 09/01/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMNavigationController.h"
#import "GMMainViewController.h"
#import "GMLoginViewController.h"

@interface GMNavigationController ()

@property (nonatomic, strong) UIViewController * viewControllerToDisplay;

@end

@implementation GMNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTranslucent:NO];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    _viewControllerToDisplay = viewController;
    [self needToHideNavigationBar];
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self needToHideNavigationBar];
    return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    self.navigationBar.hidden = YES;
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    _viewControllerToDisplay = viewController;
    [self needToHideNavigationBar];
    return [super popToViewController:viewController animated:animated];
}

- (void) needToHideNavigationBar
{
    NSArray< UIViewController *> * viewControllers = [self viewControllers];

    if (_viewControllerToDisplay != nil && [_viewControllerToDisplay isKindOfClass:[GMMainViewController class]]) {
        self.navigationBar.hidden = YES;
    }
    else if (_viewControllerToDisplay == nil && viewControllers.count <= 2 && ![viewControllers[0] isKindOfClass:[GMLoginViewController class]]){
        self.navigationBar.hidden = YES;
    }
    else {
        self.navigationBar.hidden = NO;
    }
    
    _viewControllerToDisplay = nil;
}


@end
