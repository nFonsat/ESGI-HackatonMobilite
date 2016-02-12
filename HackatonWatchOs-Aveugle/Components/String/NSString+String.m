//
//  NSString+String.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 12/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "NSString+String.h"

@implementation NSString (String)

- (BOOL)isEmpty
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0;
}


@end
