//
//  GMDangerAnnotation.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 12/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GMDanger.h"

@interface GMDangerAnnotation : NSObject <MKAnnotation>{
    NSString * _title;
    NSString * _subtitle;
    GMDanger * _danger;
    CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic, strong) GMDanger * danger;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
