//
//  GMPlaceTableViewCell.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const GMPlaceIdentifier = @"PlaceCell";

@interface GMPlaceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView * placeIcon;
@property (weak, nonatomic) IBOutlet UILabel * placeLabel;

@end
