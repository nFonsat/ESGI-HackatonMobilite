//
//  TripRepositoryFactory.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "TripRepositoryFactory.h"
#import "MockTripRepository.h"
#import "SerializableTripRepository.h"

static TripRepositoryFactory* sharedInstance_;

@implementation TripRepositoryFactory

+ (instancetype)sharedInstance {
    if (sharedInstance_ == nil){
        sharedInstance_ = [[TripRepositoryFactory alloc] init];
    }
    return sharedInstance_;
}

- (id<ITripRepository>)tripRepository{
    if (!tripRepository_){
        //tripRepository_ = [[MockTripRepository alloc]init];
        //commenter ou décommenter pour passer d'une sauvegarde à une autre
    }
    return tripRepository_;
}

@end
