//
//  GMWebUserAPI.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 17/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMWebAPI.h"

@interface GMUserWebAPI : GMWebAPI

- (void) getUserWithSuccess:(void (^)(id responseObject))success
                    Failure:(void (^)(NSError *error))failure;

- (void) postUserWithEmail:(NSString *)email
                  Username:(NSString *)username Password:(NSString *)password
                   Success:(void (^)(id responseObject))success
                   Failure:(void (^)(NSError *error))failure;

@end
