//
//  ItinaryInterfaceController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "ItinaryInterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface ItinaryInterfaceController () <WCSessionDelegate>

@end

@implementation ItinaryInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self initWCSession];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark - WCSession impl

- (void) initWCSession {
    if ([WCSession class] && [WCSession isSupported]) {
        WCSession* session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message {
    NSString* msg;
    
    if ( (msg = [message objectForKey:@"itinary"]) != nil) {
        if ([msg  isEqual: @"gauche"]) {
            [self.directionImage setImageNamed:@"gauche"];
        }
        else if ([msg  isEqual: @"droite"]) {
            [self.directionImage setImageNamed:@"droite"];
        }
        else if ([msg  isEqual: @"toutdroit"]) {
            [self.directionImage setImageNamed:@"toutdroit"];
        } else if ([msg  isEqual: @"100m"]) {
            [self.distanceLabel setText:@"100m"];
        }
        else if ([msg  isEqual: @"200m"]) {
            [self.distanceLabel setText:@"200m"];
        }
        else if ([msg  isEqual: @"300m"]) {
            [self.distanceLabel setText:@"300m"];
        }
    }
    else if ( (msg = [message objectForKey:@"isFinish"]) != nil){
        [WKInterfaceController reloadRootControllersWithNames:@[@"FinishController"] contexts:nil];
    }
    else if ( (msg = [message objectForKey:@"danger"]) != nil){
        [self presentControllerWithName:@"DangerController" context:msg];
    }
}

@end
