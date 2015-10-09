//
//  MockTripRepository.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "MockTripRepository.h"

@implementation MockTripRepository


- (void) saveTrip:(Trip *)tr{ }

- (void) deleteTrip:(Trip*) tr{

}

- (NSArray<Trip*>*) getAll {
    NSMutableArray* library = [NSMutableArray new];
    
    Address* a1 = [[Address alloc] init];
    a1.name = @"32 Rue Claude Tillier, 75012 Paris, France";
    a1.latitude = @(48.848906299999996);
    a1.longitude = @(2.3894058);
    a1.lastUse = [NSDate date];
    
    Address* a2 = [[Address alloc] init];
    a2.name = @"11 Rue Camille Desmoulins, 92300 Levallois-Perret, France";
    a2.latitude = @(48.88910074349772);
    a2.longitude = @(2.2840189933776855);
    a2.lastUse = [NSDate date];
    
//    Address* a3 = [[Address alloc] init];
//    a3.name = @"29 Rue du Buisson Moineau, 95610 Éragny, France";
//    a3.latitude = @(49.01445529346132);
//    a3.longitude = @(2.1137309074401855);
//    a3.lastUse = [NSDate date];
//    [library addObject:a3];
    
//    Trip* t1 = [[Trip alloc] init];
//    t1.name = @"Work - Home";
//    [t1 setStartAddress:a1];
//    [t1 setFinishAddress:a2] ;
//    [library addObject:t1];
    
//    Trip* t2 = [[Trip alloc] init];
//    t2.name = @"Work - Home";
//    [t1 setStartAddress:a1];
//    [t1 setFinishAddress:a3] ;
//    [library addObject:t2];
    
    return library;
}

@end