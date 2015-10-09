//
//  Address.h
//  HackatonWatchOs-Aveugle
//
//  Created by Carole Carré on 08/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject <NSCoding>

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSNumber* latitude;
@property (nonatomic, strong) NSNumber* longitude;
@property (nonatomic, strong) NSDate* lastUse;

@end
