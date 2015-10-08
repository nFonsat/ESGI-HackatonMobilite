//
//  Address.m
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "Address.h"

@implementation Address

@synthesize name = name_;
@synthesize latitude = latitude_;
@synthesize longitude = longitude_;
@synthesize lastUse = lastUse_;


- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if ( (self = [super init]) ) {
        self.name = [aDecoder decodeObjectForKey:@"NAME"];
        self.latitude = [aDecoder decodeObjectForKey:@"LATITUDE"];
        self.longitude = [aDecoder decodeObjectForKey:@"LONGITUDE"];
        self.lastUse = [aDecoder decodeObjectForKey:@"LASTUSE"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"NAME"];
    [aCoder encodeObject:self.latitude forKey:@"LATITUDE"];
    [aCoder encodeObject:self.longitude forKey:@"LONGITUDE"];
    [aCoder encodeObject:self.lastUse forKey:@"LASTUSE"];
}

-(NSString*) description {
    return [NSString stringWithFormat:@"Address [name=%@, latitude=%@, longitude=%@, , lastUse=%@]", self.name, self.latitude, self.longitude, self.lastUse];
}

- (BOOL) isEqual:(id)object{
    if ([object isKindOfClass:[Address class]]){
        Address* ad = (Address*) object;
        return [self.name isEqualToString:ad.name];
    }
    return NO;
}



@end
