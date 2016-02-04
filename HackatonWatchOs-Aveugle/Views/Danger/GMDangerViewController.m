//
//  GMDangerViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 04/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMDangerViewController.h"

@interface GMDangerViewController ()

@end

@implementation GMDangerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - GMBaseViewController

- (UIColor *)getBarTintColor
{
    return [UIColor dangerColor];
}

- (NSString *)getTitle
{
    return @"Danger";
}

@end
