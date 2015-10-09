//
//  RootInterfaceController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "RootInterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface RootInterfaceController () <WCSessionDelegate>

@end

@implementation RootInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self initWCSession];
    
    [self addMenuItemWithItemIcon:WKMenuItemIconSpeaker
                            title:@"Parler"
                           action:@selector(speakerAction) ];
    
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

- (void) speakerAction {
    [self presentTextInputControllerWithSuggestions:nil allowedInputMode:WKTextInputModePlain completion:^(NSArray *results) {
        NSLog(@"%@", results);
    }];
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
    [self inCommingMsg:message ];
}

- (void)inCommingMsg:(NSDictionary<NSString *, id> *)message{
    NSLog(@"RootInterfaceController => %@", message);
}


@end