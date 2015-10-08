//
//  TripRepositoryFactory.h
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITripRepository.h"

@interface TripRepositoryFactory : NSObject {
@private
    id<ITripRepository> tripRepository_;
}

+ (instancetype) sharedInstance;

- (id<ITripRepository>) tripRepository;


@end
