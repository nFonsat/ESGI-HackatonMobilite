//
//  GMPlaceTableViewCell.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

@import GoogleMaps;
#import <UIKit/UIKit.h>

@class GMPlaceTableViewCell;

static NSString * const GMPlaceIdentifier = @"PlaceCell";

@protocol GMPlaceTableViewCellDelegate <NSObject>

- (void)didAddFutureFavoriteLocation:(GMSAutocompletePrediction *)prediction forCell:(GMPlaceTableViewCell *)cell;

@end

@interface GMPlaceTableViewCell : UITableViewCell

@property (nonatomic, weak) id <GMPlaceTableViewCellDelegate>delegate;

- (void)loadCellWithPrediction:(GMSAutocompletePrediction *)prediction;

@end
