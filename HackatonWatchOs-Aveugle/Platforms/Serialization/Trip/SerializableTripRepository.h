//
//  SerializableTripRepository.h
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITripRepository.h"


@interface SerializableTripRepository : NSObject <ITripRepository>{
@private
    NSString* filePath_;
    NSMutableArray<Trip*>* triplist_;
}

//+ (instancetype) sharedInstance;

-(instancetype) initWithFileName:(NSString*) filename;


@end
