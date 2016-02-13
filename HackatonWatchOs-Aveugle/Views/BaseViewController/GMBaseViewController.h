//
//  GMBaseViewController.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 09/01/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JFMinimalNotifications/JFMinimalNotification.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import "UIColor+GMColor.h"
#import "NSString+String.h"

@import CoreLocation;

@interface GMBaseViewController : UIViewController
    <CLLocationManagerDelegate, JFMinimalNotificationDelegate, WCSessionDelegate>

- (void)showDefaultNotificationWithTitle:(NSString *)title Message:(NSString *)msg;

- (void)showErrorNotificationWithMessage:(NSString *)msg;

- (void)showSuccessNotificationWithMessage:(NSString *)msg;

- (void)showInfoNotificationWithTitle:(NSString *)title Message:(NSString *)msg;

- (void)showWarningNotificationMessage:(NSString *)msg;

- (void)sendMessageToWatchWithKey:(NSString *)key Value:(NSString*)value;

- (void)login;

- (void)logout;

@end
