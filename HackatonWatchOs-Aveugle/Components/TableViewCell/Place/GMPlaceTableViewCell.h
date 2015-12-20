//
//  GMPlaceTableViewCell.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMLocation.h"

@class GMPlaceTableViewCell;

static NSString * const GMPlaceIdentifier = @"PlaceCell";

@protocol GMPlaceTableViewCellDelegate <NSObject>

- (void)didAddFavoriteLocation:(GMLocation *)location forCell:(GMPlaceTableViewCell *)cell;

@end

@interface GMPlaceTableViewCell : UITableViewCell

@property (nonatomic, weak) id <GMPlaceTableViewCellDelegate>delegate;

- (void) loadCellWithPlace:(GMLocation *)location;

@end
