//
//  ReadyItinaryInterfaceController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "ReadyItinaryInterfaceController.h"

@interface ReadyItinaryInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage * logoApp;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton * readyLabel;

@end

@implementation ReadyItinaryInterfaceController

- (IBAction)onTouchReadyButton
{
    [self sendMessageToIphoneWithKey:@"start_navigation" Value:@"YES"];
}

#pragma mark - RootCommunication impl

- (void)inCommingMsg:(NSDictionary<NSString *, id> *)message {
    
    NSString * msg;
    
    if ( (msg = [message objectForKey:@"ready_navigation"]) != nil && [msg  isEqual: @"YES"]) {
        [self.logoApp setHidden:true];
        [self.readyLabel setHidden:false];
    }
    else {
        [super inCommingMsg:message];
    }
}

@end