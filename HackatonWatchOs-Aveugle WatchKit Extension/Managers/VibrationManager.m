//
//  VibrationManager.m
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import "VibrationManager.h"

static VibrationManager* sharedInstance_;

@implementation VibrationManager

+ (instancetype) sharedInstance {
    if (sharedInstance_ == nil) {
        sharedInstance_ =  [[VibrationManager alloc] init];
    }
    
    return sharedInstance_;
}

- (void) playVibrationNotification {
    [[WKInterfaceDevice currentDevice] playHaptic: WKHapticTypeNotification];
}

- (void) playVibrationSuccess {
    [[WKInterfaceDevice currentDevice] playHaptic: WKHapticTypeSuccess];
}

- (void) playVibrationFaillure {
    [[WKInterfaceDevice currentDevice] playHaptic: WKHapticTypeFailure];
}

@end
