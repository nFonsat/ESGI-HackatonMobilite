//
//  ItinaryInterfaceController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "ItinaryInterfaceController.h"

@interface ItinaryInterfaceController ()

@end

@implementation ItinaryInterfaceController

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

#pragma mark - RootCommunication impl

- (void)inCommingMsg:(NSDictionary<NSString *, id> *)message {
    NSLog(@"ItinaryInterfaceController => %@", message);
    
    NSString* msg;
    
    if ( (msg = [message objectForKey:@"direction"]) != nil) {
        if ([msg  isEqual: @"gauche"] ^ [msg  isEqual: @"toutdroit"] ^ [msg  isEqual: @"droite"]) {
            [self.directionImage setImageNamed:msg];
        }
    }
    else if ( (msg = [message objectForKey:@"distance"]) != nil) {
        [self.distanceLabel setText:msg];
    }
    else if ( (msg = [message objectForKey:@"distance"]) != nil && ([msg  isEqual: @"100m"] || [msg  isEqual: @"200m"] || [msg  isEqual: @"300m"])) {
        [self.distanceLabel setText:msg];
    }
    else {
        [super inCommingMsg:message];
    }
}

@end