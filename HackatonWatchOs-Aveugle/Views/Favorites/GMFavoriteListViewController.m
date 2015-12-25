//
//  GMFavoriteListViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 17/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMFavoriteListViewController.h"
#import "GMWebLocationAPI.h"
#import "GMLocation.h"

@interface GMFavoriteListViewController ()
{
    @private
    NSMutableArray * _favoriteLocations;
    GMWebLocationAPI * _locationWebAPI;
}

@property (weak, nonatomic) IBOutlet UITableView * tableView;

@end

@implementation GMFavoriteListViewController

- (instancetype)init
{
    if (self = [super init]) {
        _locationWebAPI = [[GMWebLocationAPI alloc] init];
        _favoriteLocations = [NSMutableArray new];
        
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
    [_locationWebAPI getLocationsSuccess:^(id responseObject)
    {
        NSLog(@"Success : %@", responseObject);
        for (NSDictionary * locationJson in responseObject) {
            GMLocation * location = [[GMLocation alloc] initFromJsonDictionary:locationJson];
            [_favoriteLocations addObject:location];
        }
        
        [self.tableView reloadData];
    }
                                 Failure:^(NSError * error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _favoriteLocations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"FavoriteCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    GMLocation * location = _favoriteLocations[indexPath.row];
    
    cell.textLabel.text = location.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate



@end
