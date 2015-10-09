//
//  SerializableAddressRepository.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "SerializableAddressRepository.h"

@implementation SerializableAddressRepository

- (instancetype) initWithFileName:(NSString *)filename {
    if((self = [super init])){
        NSArray* documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        filePath_ = [[documentPaths objectAtIndex:0]stringByAppendingPathComponent:filename];
        addresslist_ = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath_];
    }
    return self;
}


- (void) saveAddress:(Address*)ad{
    if (addresslist_ == nil){
        addresslist_ = [[NSMutableArray alloc]init];
    }
    NSInteger indexOf = [addresslist_ indexOfObject:ad];
    if(indexOf != NSNotFound){
        [addresslist_ replaceObjectAtIndex:indexOf withObject:ad];
    }else {
        [addresslist_ addObject:ad];
    }
    [NSKeyedArchiver archiveRootObject:addresslist_ toFile:filePath_];
}


- (void) deleteAddress:(Address*)ad{
    [addresslist_ removeObject:ad];
    [NSKeyedArchiver archiveRootObject:addresslist_ toFile:filePath_];
}


- (NSArray<Address*>*) getAll{
    return addresslist_;
}


- (Address*) searchAddressWithName:(NSString*)name{
    for (Address* ad in addresslist_){
        if([ad.name isEqualToString:name]){
            return ad;
        }
    }
    return nil;
}




@end
