//
//  StartItineraryInterfaceController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "StartItineraryInterfaceController.h"

@interface StartItineraryInterfaceController ()

@end

@implementation StartItineraryInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    
    [NSThread sleepForTimeInterval:3.0f];
    
    [WKInterfaceController reloadRootControllersWithNames:@[@"ItinaryController"] contexts:nil];
    
    
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



