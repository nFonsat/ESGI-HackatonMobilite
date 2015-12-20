//
//  GMPlaceTableViewCell.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMPlaceTableViewCell.h"

@interface GMPlaceTableViewCell ()
{
    @private
    GMLocation * _location;
}

@property (weak, nonatomic) IBOutlet UIImageView * placeIcon;
@property (weak, nonatomic) IBOutlet UILabel * placeLabel;
@property (weak, nonatomic) IBOutlet UIButton * placeFavoriteBtn;

- (IBAction)addFavoriteLocation:(UIButton *)sender;

@end

@implementation GMPlaceTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if (!_location) {
        self.placeFavoriteBtn.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)addFavoriteLocation:(UIButton *)sender
{
    [self.delegate didAddFavoriteLocation:_location forCell:self];
}

- (void) loadCellWithPlace:(GMLocation *)location
{
    _location = location;
    self.placeFavoriteBtn.hidden = NO;
    self.placeLabel.text = _location.name;
}

@end
