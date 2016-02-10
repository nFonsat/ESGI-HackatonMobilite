//
//  GMDanger.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 03/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMDanger.h"

@implementation GMDanger

@synthesize dangerId    = _dangerId;
@synthesize name        = _name;
@synthesize type        = _type;
@synthesize coordinate  = _coordinate;



- (instancetype)initWithDangerId:(NSString *)dangerId
                            Name:(NSString *)name
                      TypeDanger:(GMTypeDanger *)type
                      Coordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [self init]) {
        _dangerId = dangerId;
        _name = name;
        _type = type;
        _coordinate = coordinate;
    }
    
    return self;
}

- (instancetype)initFromJsonDictionary:(NSDictionary *)json
{
    NSString * dangerId = [json objectForKey:@"_id"];
    NSString * name     = [json objectForKey:@"name"];
    
    NSDictionary * typeObject = [json objectForKey:@"type"];
    GMTypeDanger * type = [[GMTypeDanger alloc] initFromJsonDictionary:typeObject];
    
    NSDictionary * coordinateObject = [json objectForKey:@"coordinate"];
    NSArray<NSNumber *> * geometry = [coordinateObject objectForKey:@"geometry"];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(geometry[0].doubleValue, geometry[1].doubleValue);
    
    return [self initWithDangerId:dangerId Name:name TypeDanger:type Coordinate:coordinate];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{%@:[%f,%f]:%@}", _name, _coordinate.latitude, _coordinate.longitude, _type.name];
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[GMDanger class]]) {
        return NO;
    }
    
    GMDanger * dangerToCompare = (GMDanger *)object;
    return ((dangerToCompare.coordinate.latitude == self.coordinate.latitude)
            && (dangerToCompare.coordinate.longitude == self.coordinate.longitude));
}

@end
