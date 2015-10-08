//
//  DangerInterfaceController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "DangerInterfaceController.h"
#import "VibrationManager.h"

@interface DangerInterfaceController () {
    NSString* imgNamed_;
}

@end

@implementation DangerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    imgNamed_ = context;
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [[VibrationManager sharedInstance] playVibrationFaillure];
    
    if (imgNamed_ != nil) {
        [self.dangerBtn setBackgroundImageNamed:imgNamed_];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)onFinishAlert {
    [self dismissController];
}

@end



