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

- (void)loadDirectionFromString:(NSString *)direction
{
    NSString * directionFound = nil;
    
    if ([direction isEqualToString:@"left"]) {
        directionFound = @"gauche";
    }
    else if ([direction isEqualToString:@"right"]) {
        directionFound = @"droite";
    }
    else if ([direction isEqualToString:@"center"]) {
        directionFound = @"toutdroit";
    }
    
    
    if (directionFound != nil) {
        [self.directionImage setImageNamed:directionFound];
    }
}

#pragma mark - RootCommunication impl

- (void)inCommingMsg:(NSDictionary<NSString *, id> *)message {
    
    NSString* msg;
    
    if ( (msg = [message objectForKey:kWatchStepDirection]) != nil) {
        [self loadDirectionFromString:msg];
    }
    else if ( (msg = [message objectForKey:kWatchStepDistance]) != nil) {
        [self.distanceLabel setText:msg];
    }
    else if ((msg = [message objectForKey:kWatchDestinationName]) != nil){
        [self.nameLabel setText:msg];
    }
    else {
        [super inCommingMsg:message];
    }
}

@end