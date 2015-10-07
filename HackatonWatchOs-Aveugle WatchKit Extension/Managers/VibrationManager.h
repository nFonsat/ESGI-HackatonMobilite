//
//  VibrationManager.h
//  HackatonWatchOs-Aveugle
//
//  Created by Etudiant on 07/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface VibrationManager : NSObject

+ (instancetype) sharedInstance;

- (void) playVibrationNotification; //Départ

- (void) playVibrationSuccess; //Arrivé

- (void) playVibrationFaillure; //Zone de danger

@end
