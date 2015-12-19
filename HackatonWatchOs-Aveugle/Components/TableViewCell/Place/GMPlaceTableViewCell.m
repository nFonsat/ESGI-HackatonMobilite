//
//  GMPlaceTableViewCell.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMPlaceTableViewCell.h"

@interface GMPlaceTableViewCell ()

- (IBAction)addFavoriteLocation:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView * placeIcon;
@property (weak, nonatomic) IBOutlet UILabel * placeLabel;

@end

@implementation GMPlaceTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)addFavoriteLocation:(UIButton *)sender
{
    NSLog(@"addFavoriteLocation");
}

- (void) loadCellWithPlace:(GMLocation *)location
{
    self.placeLabel.text = location.name;
}

@end
