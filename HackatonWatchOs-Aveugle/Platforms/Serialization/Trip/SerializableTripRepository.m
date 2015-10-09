//
//  SerializableTripRepository.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "SerializableTripRepository.h"

@implementation SerializableTripRepository

- (instancetype) initWithFileName:(NSString *)filename {
    if((self = [super init])){
        NSArray* documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        filePath_ = [[documentPaths objectAtIndex:0]stringByAppendingPathComponent:filename];
        triplist_ = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath_];
    }
    return self;
}


- (void) saveTrip:(Trip*)tr{
    if (triplist_ == nil){
        triplist_ = [[NSMutableArray alloc]init];
    }
    NSInteger indexOf = [triplist_ indexOfObject:tr];
    if(indexOf != NSNotFound){
        [triplist_ replaceObjectAtIndex:indexOf withObject:tr];
    }else {
        [triplist_ addObject:tr];
    }
    [NSKeyedArchiver archiveRootObject:triplist_ toFile:filePath_];
}


- (void) deleteTrip:(Trip*)tr{
    [triplist_ removeObject:tr];
    [NSKeyedArchiver archiveRootObject:triplist_ toFile:filePath_];
}


- (NSArray<Trip*>*) getAll{
    return triplist_;
}


- (Trip*) searchTripWithName:(NSString*)name{
    for (Trip* tr in triplist_){
        if([tr.name isEqualToString:name]){
            return tr;
        }
    }
    return nil;
}




@end
