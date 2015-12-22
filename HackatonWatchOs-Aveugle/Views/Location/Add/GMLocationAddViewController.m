//
//  GMLocationAddViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//
#import "GMLocationAddViewController.h"
#import "GMLocationMapViewController.h"
#import "GMLocation.h"
#import "GMWebLocationAPI.h"

@import GoogleMaps;

@interface GMLocationAddViewController ()
{
    @private
    NSMutableArray<GMSAutocompletePrediction *> * _placeResults;
    GMSPlacesClient * _googleClient;
    GMWebLocationAPI * _locationWebAPI;
    GMSPlace * _placeToAdded;
}

@property (weak, nonatomic) IBOutlet UISearchBar * searchBar;
@property (weak, nonatomic) IBOutlet UITableView * tableView;

@end

@implementation GMLocationAddViewController

- (instancetype)init
{
    if (self = [super init]) {
        _locationWebAPI = [[GMWebLocationAPI alloc] init];
        _googleClient   = [[GMSPlacesClient alloc] init];
        _placeResults   = [NSMutableArray new];
        
        self.searchBar.delegate = self;
        self.tableView.delegate = self;
        self.tableView.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - GMLocationAddViewController Helper

- (void)searchGooglePlaceWithPlaceID:(NSString *)placeID
                             Success:(void (^)(GMSPlace *place))sucess
                            Faillure:(void (^)(NSError *error))faillure
{
    [_googleClient lookUpPlaceID:placeID
                        callback:^(GMSPlace *place, NSError *error)
     {
         if (error != nil) {
             faillure(error);
             return;
         }
         
         if (place != nil) {
             sucess(place);
         } else {
             faillure(nil);
         }
     }];
}

- (BOOL)verificationAutocompleteForString:(NSString *)string
{
    NSInteger count = string.length;
    NSString * lastChar = [string substringFromIndex:count - 1];
    
    return count > 3 && ![lastChar isEqualToString:@" "];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText isEqualToString:@""]){
        [_placeResults removeAllObjects];
        [self.tableView reloadData];
    }
    else if ([self verificationAutocompleteForString:searchText]) {
        GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
        filter.type = kGMSPlacesAutocompleteTypeFilterNoFilter;
        
        [_googleClient autocompleteQuery:searchText
                                  bounds:nil
                                  filter:filter
                                callback:^(NSArray *results, NSError *error)
        {
            if (error != nil) {
                NSLog(@"Autocomplete error %@", [error localizedDescription]);
                return;
            }
            
            [_placeResults removeAllObjects];
            
            for (GMSAutocompletePrediction * result in results) {
                [_placeResults addObject:result];
            }
            
            [self.tableView reloadData];
        }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _placeResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMPlaceTableViewCell *cell = (GMPlaceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:GMPlaceIdentifier];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GMPlaceTableViewCell" bundle:nil] forCellReuseIdentifier:GMPlaceIdentifier];
        cell = (GMPlaceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:GMPlaceIdentifier];
    }
    
    GMSAutocompletePrediction * prediction = [_placeResults objectAtIndex:indexPath.row];
    [cell loadCellWithPrediction:prediction];
    
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMSAutocompletePrediction * prediction = _placeResults[indexPath.row];
    
    [self searchGooglePlaceWithPlaceID:prediction.placeID
                               Success:^(GMSPlace *place)
    {
        GMLocation * location = [[GMLocation alloc] initWithLocationId:place.placeID Name:place.name Coordinate:place.coordinate];
        GMLocationMapViewController * mapView = [[GMLocationMapViewController alloc] initWithGMLocation:location];
        [self.navigationController pushViewController:mapView animated:YES];
    }
                              Faillure:^(NSError *error)
    {
        if (error != nil) {
            NSLog(@"Place Details error %@", [error localizedDescription]);
        }
        else {
            NSLog(@"No place details for %@", prediction.placeID);
        }
    }];
}

#pragma mark - GMPlaceTableViewCellDelegate

- (void)didAddFutureFavoriteLocation:(GMSAutocompletePrediction *)prediction forCell:(GMPlaceTableViewCell *)cell;
{
    [self searchGooglePlaceWithPlaceID:prediction.placeID
                               Success:^(GMSPlace * place)
     {
         _placeToAdded = place;
         UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Confirm location"
                                                          message:@"Confirm name location"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
         
         alert.alertViewStyle = UIAlertViewStylePlainTextInput;
         UITextField * textField = [alert textFieldAtIndex:0];
         textField.text = place.name;
         [alert show];
     }
                              Faillure:^(NSError *error)
     {
         if (error != nil) {
             NSLog(@"Place Details error %@", [error localizedDescription]);
         }
         else {
             NSLog(@"No place details for %@", prediction.placeID);
         }
     }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            break;
        }
        
        case 1:
        {
            UITextField * textField = [alertView textFieldAtIndex:0];
            if (!textField.text) {
                return;
            }
            
            CLLocation * location = [[CLLocation alloc] initWithLatitude:_placeToAdded.coordinate.latitude
                                                               longitude:_placeToAdded.coordinate.longitude];
            
            [_locationWebAPI postLocationWithName:textField.text
                                         Location:location
                                          Success:^(id responseObject)
            {
                NSLog(@"Success: %@", responseObject);
            }
                                          Failure:^(NSError *error)
            {
                NSLog(@"Error: %@", error.userInfo);
            }];
            
            break;
        }
            
        default:
            break;
    }
}

@end
