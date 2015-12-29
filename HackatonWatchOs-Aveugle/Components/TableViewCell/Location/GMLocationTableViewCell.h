//
//  GMLocationTableViewCell.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 25/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMLOcation.h"

static NSString * const GMLocationIdentifier = @"LocationCell";

@interface GMLocationTableViewCell : UITableViewCell

- (void)loadCellWithLocation:(GMLocation *)location;

@end
