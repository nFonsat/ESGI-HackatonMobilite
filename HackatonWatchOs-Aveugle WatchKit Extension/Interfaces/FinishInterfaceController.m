//
//  FinishInterfaceController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "FinishInterfaceController.h"

@interface FinishInterfaceController ()
@end

@implementation FinishInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [NSThread sleepForTimeInterval:10.0f];
    
    [WKInterfaceController reloadRootControllersWithNames:@[@"ReadyItinaryController"] contexts:nil];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}



@end



