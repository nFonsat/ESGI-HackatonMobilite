//
//  GMLocationAddViewController.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMPlaceTableViewCell.h"

@interface GMLocationAddViewController : UIViewController
    <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate , GMPlaceTableViewCellDelegate>

@end
