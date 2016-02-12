//
//  UIColor+GMColor.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 09/01/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "UIColor+GMColor.h"

@implementation UIColor (GMColor)

+ (UIColor *)favoriteColor
{
    return [UIColor trueColorWithRed:255 green:215 blue:0 alpha:1];
}

+ (UIColor *)mapColor
{
    return [UIColor trueColorWithRed:0 green:196 blue:203 alpha:1];
}

+ (UIColor *)navigationColor
{
    return [UIColor trueColorWithRed:0 green:190 blue:72 alpha:1];
}

+ (UIColor *)historyColor
{
    return [UIColor trueColorWithRed:250 green:0 blue:150 alpha:1];
}

+ (UIColor *)dangerColor
{
    return [UIColor trueColorWithRed:179 green:58 blue:58 alpha:1];
}

+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIColor *)trueColorWithRed:(CGFloat)redValue green:(CGFloat)greenValue blue:(CGFloat)blueValue alpha:(CGFloat)alpha
{
    CGFloat red   = redValue/255.0f;
    CGFloat green = greenValue/255.0f;
    CGFloat blue  = blueValue/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}



@end
