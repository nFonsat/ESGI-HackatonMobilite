//
//  Trip.h
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"

@interface Trip : NSObject <NSCoding>

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) Address* startAddress;
@property (nonatomic, strong) Address* finishAddress;
@property (nonatomic, strong) NSDate* lastUse;

@end
