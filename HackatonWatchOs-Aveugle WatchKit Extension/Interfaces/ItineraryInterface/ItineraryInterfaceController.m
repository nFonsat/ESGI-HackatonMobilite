//
//  ItinaryInterfaceController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "ItineraryInterfaceController.h"

@interface ItineraryInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage * directionImage;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel * distanceLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel * nameLabel;

@end

@implementation ItineraryInterfaceController

#pragma mark - RootCommunication impl

- (void)inCommingMsg:(NSDictionary<NSString *, id> *)message {
    
    NSString* msg;
    
    if ( (msg = [message objectForKey:@"direction"]) != nil) {
        if ([msg  isEqual: @"gauche"] ^ [msg  isEqual: @"toutdroit"] ^ [msg  isEqual: @"droite"]) {
            [self.directionImage setImageNamed:msg];
        }
    }
    else if ( (msg = [message objectForKey:@"distance"]) != nil) {
        [self.distanceLabel setText:msg];
    }
    else if ((msg = [message objectForKey:@"destination_name"]) != nil){
        [self.nameLabel setText:msg];
    }
    else {
        [super inCommingMsg:message];
    }
}

@end