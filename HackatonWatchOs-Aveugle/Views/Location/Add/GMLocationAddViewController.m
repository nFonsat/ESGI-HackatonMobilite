//
//  GMLocationAddViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//
#import <GoogleMaps/GoogleMaps.h>
#import "GMLocationAddViewController.h"
#import "GMPlaceTableViewCell.h"

@interface GMLocationAddViewController ()
{
    @private
    NSMutableArray * _placeResults;
    GMSPlacesClient * _googleClient;
}

@property (weak, nonatomic) IBOutlet UISearchBar * searchBar;
@property (weak, nonatomic) IBOutlet UITableView * tableView;

@end

@implementation GMLocationAddViewController

- (instancetype)init
{
    if (self = [super init]) {
        _googleClient = [[GMSPlacesClient alloc] init];
        _placeResults = [NSMutableArray new];
        
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
    if (searchText.length >= 3) {
        GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
        filter.type = kGMSPlacesAutocompleteTypeFilterNoFilter;
        
        [_googleClient autocompleteQuery:searchText
                                  bounds:nil
                                  filter:filter
                                callback:^(NSArray *results, NSError *error) {
                                    if (error != nil) {
                                        NSLog(@"Autocomplete error %@", [error localizedDescription]);
                                        return;
                                    }
                                    
                                    [_placeResults removeAllObjects];
                                    
                                    for (GMSAutocompletePrediction* result in results) {
                                        NSLog(@"Result '%@' with placeID %@", result.attributedFullText.string, result.placeID);
                                        [_placeResults addObject:result.attributedFullText.string];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlaceCell"];
    }
    
    cell.textLabel.text = [_placeResults objectAtIndex:indexPath.row];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
