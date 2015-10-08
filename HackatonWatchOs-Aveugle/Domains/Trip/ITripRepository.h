//
//  ITripRepository.h
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Trip.h"

@protocol ITripRepository <NSObject>
@required

- (void) saveTrip:(Trip*)tr;
- (void) deleteAddress:(Trip*)tr;
- (NSArray<Trip*>*) getAll;
- (Trip*) searchTripWithName:(NSString*)name;

@end