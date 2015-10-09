//
//  SerializableAddressRepository.h
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAddressRepository.h"

@interface SerializableAddressRepository : NSObject <IAddressRepository>{
@private
    NSString* filePath_;
    NSMutableArray<Address*>* addresslist_;
}

//+ (instancetype) sharedInstance;

-(instancetype) initWithFileName:(NSString*) filename;

@end

