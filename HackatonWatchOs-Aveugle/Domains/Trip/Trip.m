//
//  Trip.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "Trip.h"

@implementation Trip

@synthesize name = name_;
@synthesize startAddress = startAddress_;
@synthesize finishAddress = finishAddress_;
@synthesize lastUse = lastUse_;


- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if ( (self = [super init]) ) {
        self.name = [aDecoder decodeObjectForKey:@"NAME"];
        self.startAddress = [aDecoder decodeObjectForKey:@"STARTADDRESS"];
        self.finishAddress = [aDecoder decodeObjectForKey:@"FINISHADDRESS"];
        self.lastUse = [aDecoder decodeObjectForKey:@"LASTUSE"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"NAME"];
    [aCoder encodeObject:self.startAddress forKey:@"STARTADDRESS"];
    [aCoder encodeObject:self.finishAddress forKey:@"FINISHADDRESS"];
    [aCoder encodeObject:self.lastUse forKey:@"LASTUSE"];
}

-(NSString*) description {
    return [NSString stringWithFormat:@"Trip [name=%@, startaddress=%@, finishaddress=%@, , lastUse=%@]", self.name, self.startAddress, self.finishAddress, self.lastUse];
}

- (BOOL) isEqual:(id)object{
    if ([object isKindOfClass:[Trip class]]){
        Trip* tr = (Trip*) object;
        return [self.name isEqualToString:tr.name];
    }
    
    return NO;
}

@end
