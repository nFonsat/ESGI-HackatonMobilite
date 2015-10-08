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
    NSString* msg = [message objectForKey:@"danger"];
    
    [self presentControllerWithName:@"DangerController" context:msg];
}

@end
