//
//  MockAddressRepository.h
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAddressRepository.h"

@interface MockAddressRepository : NSObject <IAddressRepository>

- (void) saveAddress:(Address*) ad;

- (void) deleteAddress:(Address*) ad;

- (NSArray<Address*>*) getAll;

@end