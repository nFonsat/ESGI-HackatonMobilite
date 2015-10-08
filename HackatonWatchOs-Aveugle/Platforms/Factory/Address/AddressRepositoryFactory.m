//
//  AddressRepositoryFactory.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "AddressRepositoryFactory.h"
#import "MockAddressRepository.h"
#import "SerializableAddressRepository.h"

static AddressRepositoryFactory* sharedInstance_;


@implementation AddressRepositoryFactory

+ (instancetype)sharedInstance {
    if (sharedInstance_ == nil){
        sharedInstance_ = [[AddressRepositoryFactory alloc] init];
    }
    return sharedInstance_;
}

- (id<IAddressRepository>)addressRepository{
    if (!addressRepository_){
        addressRepository_ = [[MockAddressRepository alloc]init];
    }
    return addressRepository_;
}

@end