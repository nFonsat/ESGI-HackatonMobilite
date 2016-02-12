//
//  GMTypeDangerViewController.h
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 07/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMBaseViewController.h"
#import "GMTypeDanger.h"

@protocol GMTypeDangerViewControllerDelegate<NSObject>

@required

- (void)userDidChooseTypeDanger:(GMTypeDanger *)typeDanger;

@end

@interface GMTypeDangerViewController : GMBaseViewController  <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) id <GMTypeDangerViewControllerDelegate> delegate;

@end
