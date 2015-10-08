//
//  MockAddressRepository.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "MockAddressRepository.h"

@implementation MockAddressRepository


- (void) saveAddress:(Address *)ad{ }

- (void) deleteAddress:(Address*) ad{ }

- (NSArray<Address*>*) getAll {
    NSMutableArray* library = [NSMutableArray new];
    Address* a1 = [[Address alloc] init];
    a1.name = @"32 Rue Claude Tillier, 75012 Paris, France";
    a1.latitude = @(48.848906299999996);
    a1.longitude = @(2.3894058);
    a1.lastUse = [NSDate date];
    [library addObject:a1];
    
    Address* a2 = [[Address alloc] init];
    a2.name = @"11 Rue Camille Desmoulins, 92300 Levallois-Perret, France";
    a2.latitude = @(48.88910074349772);
    a2.longitude = @(2.2840189933776855);
    a2.lastUse = [NSDate date];
    [library addObject:a2];
    
    return library;
}

@end
