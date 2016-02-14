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

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    
    [self initWCSession];
    
    [self addMenuItemWithItemIcon:WKMenuItemIconSpeaker
                            title:@"Parler"
                           action:@selector(speakerAction) ];
}

- (void)willActivate
{
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate
{
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void) speakerAction
{
    [self presentTextInputControllerWithSuggestions:nil
                                   allowedInputMode:WKTextInputModePlain
                                         completion:^(NSArray *results)
    {
        //Implement Action
    }];
}


#pragma mark - WCSession impl

- (void) initWCSession
{
    if ([WCSession class] && [WCSession isSupported]) {
        WCSession* session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message
{
    [self inCommingMsg:message ];
}

- (void)sendMessageToIphoneWithKey:(NSString *)key Value:(NSString*)value
{
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession] sendMessage:@{key:value}
                                   replyHandler:nil
                                   errorHandler:nil];
    }
}

- (void)inCommingMsg:(NSDictionary<NSString *, id> *)message
{
    NSString* msg;
    
    if ( (msg = [message objectForKey:@"isFinish"]) != nil){
        [WKInterfaceController reloadRootControllersWithNames:@[@"FinishController"] contexts:nil];
    }
    else if ( (msg = [message objectForKey:@"stopNavigation"]) != nil && [msg isEqual:@"YES"]){
        [WKInterfaceController reloadRootControllersWithNames:@[@"ReadyItinaryController"] contexts:nil];
    }
    else if ( (msg = [message objectForKey:@"start_navigation"]) != nil){
        [WKInterfaceController reloadRootControllersWithNames:@[@"ItineraryController"] contexts:nil];
    }
    else if ( (msg = [message objectForKey:@"danger"]) != nil){
        [self presentControllerWithName:@"DangerController" context:msg];
    }
}


@end