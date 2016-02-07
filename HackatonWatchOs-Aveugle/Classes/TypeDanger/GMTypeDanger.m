//
//  GMTypeDanger.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 03/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMTypeDanger.h"

@implementation GMTypeDanger

@synthesize typeDangerId    = _typeDangerId;
@synthesize name            = _name;
@synthesize icon            = _icon;

- (instancetype)initWithTypeDangerId:(NSString *)typeDangerId
                                Name:(NSString *)name
                                Icon:(NSString *)icon
{
    if (self = [self init]) {
        _typeDangerId = typeDangerId;
        _name = name;
        _icon = icon;
    }
    
    return self;
}

- (instancetype)initFromJsonDictionary:(NSDictionary *)json
{

    NSString * typeId = [json objectForKey:@"_id"];
    NSString * name   = [json objectForKey:@"name"];
    NSString * icon   = [json objectForKey:@"icon"];
    
    return [self initWithTypeDangerId:typeId Name:name Icon:icon];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{%@:%@}", _name, _icon];
}

@end
