//
//  GMHistoriesViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 02/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMHistoriesViewController.h"
#import "GMLocationMapViewController.h"
#import "GMLocationTableViewCell.h"
#import "GMWebLocationAPI.h"
#import "GMLocation.h"
#import "UIColor+GMColor.h"

@interface GMHistoriesViewController ()
{
@private
}

@property (nonatomic, strong) NSMutableArray<GMLocation *> * hitories;
@property (nonatomic, strong) GMWebLocationAPI * locationWebAPI;


@property (weak, nonatomic) IBOutlet UITableView * tableView;

@end

@implementation GMHistoriesViewController

- (instancetype)init
{
    if (self = [super init]) {
        _locationWebAPI = [[GMWebLocationAPI alloc] init];
        
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
    
    _hitories = [NSMutableArray new];
    
    [_locationWebAPI getHistoriesSuccess:^(id responseObject)
     {
         for (NSDictionary * locationJson in responseObject) {
             GMLocation * location = [[GMLocation alloc] initFromJsonDictionary:locationJson];
             [_hitories addObject:location];
         }
         
         [self.tableView reloadData];
     }
                                 Failure:^(NSError * error)
     {
         NSLog(@"Error : %@", error.localizedDescription);
     }];
}

#pragma mark - GMBaseViewController

- (UIColor *)getBarTintColor
{
    return [UIColor historyColor];
}

- (NSString *)getTitle
{
    return @"Histories";
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _hitories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"HistoryCell"];
    }
    
    GMLocation * location = _hitories[indexPath.row];
    
    cell.textLabel.text = location.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", location.navigateTo];
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMLocation * location = _hitories[indexPath.row];
    
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
        {
            [_locationWebAPI deleteLocationWithLocationId:location.locationId
                                                  Success:^(id responseObject)
             {
                 [_hitories removeObject:location];
                 [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
             }
                                                  Failure:^(NSError * error)
             {
                 NSLog(@"Error : %@", error.localizedDescription);
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
    GMLocation * location = _hitories[indexPath.row];
    GMLocationMapViewController * mapView = [[GMLocationMapViewController alloc] initWithGMLocation:location];
    [self.navigationController pushViewController:mapView animated:YES];
}



@end
