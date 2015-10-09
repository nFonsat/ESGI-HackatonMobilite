//
//  ReadyItinaryInterfaceController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "ReadyItinaryInterfaceController.h"

@interface ReadyItinaryInterfaceController ()

@end

@implementation ReadyItinaryInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
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

- (IBAction)onTouchReadyButton {
    [WKInterfaceController reloadRootControllersWithNames:@[@"StartItinaryController"] contexts:nil];
}

#pragma mark - RootCommunication impl

- (void)inCommingMsg:(NSDictionary<NSString *, id> *)message {
    NSLog(@"ReadyItinaryInterfaceController => %@", message);
    
    NSString* msg;
    if ( (msg = [message objectForKey:@"isReady"]) != nil && [msg  isEqual: @"true"]) {
        [self.logoApp setHidden:true];
        [self.readyLabel setHidden:false];
    } else {
        [super inCommingMsg:message];
    }
}

@end