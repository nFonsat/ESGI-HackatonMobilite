//
//  GMLocationAddViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//
#import <GoogleMaps/GoogleMaps.h>
#import "GMLocationAddViewController.h"
#import "GMLocation.h"
#import "GMWebLocationAPI.h"

@interface GMLocationAddViewController ()
{
    @private
    NSMutableArray * _placeResults;
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

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length > 3) {
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
            
            for (GMSAutocompletePrediction* result in results) {
                //NSLog(@"Result '%@' with placeID %@", result.attributedFullText.string, result.placeID);
                GMLocation * location = [[GMLocation alloc] initWithLocationId:result.placeID
                                                                          Name:result.attributedFullText.string
                                                                 isGooglePlace:YES];
                
                [_placeResults addObject:location];
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
    
    GMLocation * location = [_placeResults objectAtIndex:indexPath.row];
    [cell loadCellWithPlace:location];
    
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate



#pragma mark - GMPlaceTableViewCellDelegate

- (void)didAddFavoriteLocation:(GMLocation *)location forCell:(GMPlaceTableViewCell *)cell
{
    [_googleClient lookUpPlaceID:location.locationId
                        callback:^(GMSPlace *place, NSError *error)
     {
         if (error != nil) {
             NSLog(@"Place Details error %@", [error localizedDescription]);
             return;
         }
         
         if (place != nil) {
             _placeToAdded = place;
             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Confirm location"
                                                              message:@"Confirm name location"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
             
             alert.alertViewStyle = UIAlertViewStylePlainTextInput;
             UITextField * textField = [alert textFieldAtIndex:0];
             textField.text = place.name;
             [alert show];
         } else {
             NSLog(@"No place details for %@", location.locationId);
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
