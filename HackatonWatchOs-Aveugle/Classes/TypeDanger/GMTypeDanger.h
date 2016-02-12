//
//  GMTypeDanger.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 03/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMTypeDanger : NSObject
{
    NSString * _typeDangerId;
    NSString * _name;
    NSString * _icon;
}

@property (nonatomic, strong) NSString * typeDangerId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * icon;

- (instancetype)initWithTypeDangerId:(NSString *)typeDangerId
                                Name:(NSString *)name
                                Icon:(NSString *)icon;

- (instancetype)initFromJsonDictionary:(NSDictionary *)json;

@end
