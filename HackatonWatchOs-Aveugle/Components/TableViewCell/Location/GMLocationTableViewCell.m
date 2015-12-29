//
//  GMLocationTableViewCell.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 25/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMLocationTableViewCell.h"

@interface GMLocationTableViewCell ()
{
    @private
}

@property (weak, nonatomic) IBOutlet UILabel * placeLabel;

@end

@implementation GMLocationTableViewCell

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)loadCellWithLocation:(GMLocation *)location
{
    self.placeLabel.text = location.name;
}

@end
