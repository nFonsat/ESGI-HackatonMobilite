//
//  GMBaseViewController.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 09/01/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JFMinimalNotifications/JFMinimalNotification.h>
#import "UIColor+GMColor.h"

@import CoreLocation;

@interface GMBaseViewController : UIViewController <CLLocationManagerDelegate, JFMinimalNotificationDelegate>

- (void)showDefaultNotificationWithTitle:(NSString *)title Message:(NSString *)msg;

- (void)showErrorNotificationWithMessage:(NSString *)msg;

- (void)showSuccessNotificationWithMessage:(NSString *)msg;

- (void)showInfoNotificationWithTitle:(NSString *)title Message:(NSString *)msg;

- (void)showWarningNotificationMessage:(NSString *)msg;

@end
