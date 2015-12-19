//
//  GMLocationAddViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//
#import <GoogleMaps/GoogleMaps.h>
#import "GMLocationAddViewController.h"

@interface GMLocationAddViewController ()
{
    @private
    NSArray * _placeResults;
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
        
        _placeResults = [NSArray new];
        
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
                                    
                                    for (GMSAutocompletePrediction* result in results) {
                                        NSLog(@"Result '%@' with placeID %@", result.attributedFullText.string, result.placeID);
                                    }
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
    return nil;
}

#pragma mark - UITableViewDelegate

@end
