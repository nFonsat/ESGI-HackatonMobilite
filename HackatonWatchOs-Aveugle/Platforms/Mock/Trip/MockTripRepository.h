//
//  MockTripRepository.h
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITripRepository.h"

@interface MockTripRepository : NSObject <ITripRepository>

- (void) saveTrip:(Trip*) tr;

- (void) deleteTrip:(Trip*) tr;

- (NSArray<Trip*>*) getAll;

@end
