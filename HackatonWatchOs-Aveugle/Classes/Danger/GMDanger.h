//
//  GMDanger.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 03/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import <Foundation/Foundation.h>
#import "GMTypeDanger.h"

@interface GMDanger : NSObject
{
    NSString * _dangerId;
    NSString * _name;
    GMTypeDanger * _type;
    CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, strong) NSString * dangerId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) GMTypeDanger * type;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (instancetype)initWithDangerId:(NSString *)dangerId
                            Name:(NSString *)name
                      TypeDanger:(GMTypeDanger *)type
                      Coordinate:(CLLocationCoordinate2D)coordinate;

- (instancetype)initFromJsonDictionary:(NSDictionary *)json;

@end
