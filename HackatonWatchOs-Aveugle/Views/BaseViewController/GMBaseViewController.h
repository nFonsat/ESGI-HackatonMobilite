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

@interface GMBaseViewController : UIViewController <CLLocationManagerDelegate>

- (void)showDefaultNotificationWithTitle:(NSString *)title Message:(NSString *)msg;

- (void)showErrorNotificationWithTitle:(NSString *)title Message:(NSString *)msg;

- (void)showSuccessNotificationWithTitle:(NSString *)title Message:(NSString *)msg;

- (void)showInfoNotificationWithTitle:(NSString *)title Message:(NSString *)msg;

- (void)showWarningNotificationWithTitle:(NSString *)title Message:(NSString *)msg;

@end
