//
//  RootInterfaceController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "RootInterfaceController.h"

@interface RootInterfaceController ()

@end

@implementation RootInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
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
    NSLog(@"speakerAction");
}

@end



