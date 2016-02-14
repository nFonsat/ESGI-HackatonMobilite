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

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [NSThread sleepForTimeInterval:10.0f];
    
    [WKInterfaceController reloadRootControllersWithNames:@[@"ReadyItinaryController"] contexts:nil];
}



@end



