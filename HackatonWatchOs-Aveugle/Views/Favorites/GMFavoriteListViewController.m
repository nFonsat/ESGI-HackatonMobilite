//
//  GMFavoriteListViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 17/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMFavoriteListViewController.h"
#import "GMLocationMapViewController.h"
#import "GMLocationTableViewCell.h"
#import "GMLocationWebAPI.h"
#import "GMLocation.h"
#import "UIColor+GMColor.h"


@interface GMFavoriteListViewController ()
{
    @private
}

@property (nonatomic, strong) NSMutableArray<GMLocation *> * favoriteLocations;
@property (nonatomic, strong) GMLocationWebAPI * locationWebAPI;


@property (weak, nonatomic) IBOutlet UITableView * tableView;

@end

@implementation GMFavoriteListViewController

- (instancetype)init
{
    if (self = [super init]) {
        _locationWebAPI = [[GMLocationWebAPI alloc] init];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _favoriteLocations = [NSMutableArray new];
    
    [_locationWebAPI getFavoritesSuccess:^(id responseObject)
    {
        for (NSDictionary * locationJson in responseObject) {
            GMLocation * location = [[GMLocation alloc] initFromJsonDictionary:locationJson];
            [_favoriteLocations addObject:location];
        }
        
        [self.tableView reloadData];
    }
                                 Failure:^(NSError * error)
    {
        [self showErrorNotificationWithMessage:@"Impossible to load favorite location"];
    }];
}

#pragma mark - GMBaseViewController

- (UIColor *)getBarTintColor
{
    return [UIColor favoriteColor];
}

- (NSString *)getTitle
{
    return @"Favorite address";
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _favoriteLocations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMLocationTableViewCell * cell = (GMLocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:GMLocationIdentifier];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GMLocationTableViewCell" bundle:nil] forCellReuseIdentifier:GMLocationIdentifier];
        cell = (GMLocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:GMLocationIdentifier];
    }
    
    GMLocation * location = _favoriteLocations[indexPath.row];
    [cell loadCellWithLocation:location];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMLocation * location = _favoriteLocations[indexPath.row];
    
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
        {
            [_locationWebAPI deleteLocationWithLocationId:location.locationId
                                                  Success:^(id responseObject)
            {
                [_favoriteLocations removeObject:location];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
                                                  Failure:^(NSError * error)
            {
                [self showErrorNotificationWithMessage:@"Impossible to remove favorite location"];
            }];
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMLocation * location = _favoriteLocations[indexPath.row];
    GMLocationMapViewController * mapView = [[GMLocationMapViewController alloc] initWithGMLocation:location];
    [self.navigationController pushViewController:mapView animated:YES];
}



@end
