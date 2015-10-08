//
//  AddressRepositoryFactory.h
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAddressRepository.h"

@interface AddressRepositoryFactory : NSObject {
@private
    id<IAddressRepository> addressRepository_;
}

+ (instancetype) sharedInstance;

- (id<IAddressRepository>) addressRepository;

@end
