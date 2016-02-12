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

- (BOOL)isEmailValid
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


@end
