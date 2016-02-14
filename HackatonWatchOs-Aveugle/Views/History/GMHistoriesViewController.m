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
#import "GMLocationWebAPI.h"
#import "GMLocation.h"
#import "UIColor+GMColor.h"

@interface GMHistoriesViewController ()
{
@private
}

@property (nonatomic, strong) NSMutableArray<GMLocation *> * hitories;
@property (nonatomic, strong) GMLocationWebAPI * locationWebAPI;


@property (weak, nonatomic) IBOutlet UITableView * tableView;

@end

@implementation GMHistoriesViewController

- (instancetype)init
{
    if (self = [super init]) {
        _locationWebAPI = [GMLocationWebAPI sharedLocationWebAPI];
        
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
         [self showErrorNotificationWithMessage:@"Impossible to load histories"];
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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMLocation * location = _hitories[indexPath.row];
    GMLocationMapViewController * mapView = [[GMLocationMapViewController alloc] initWithGMLocation:location];
    [self.navigationController pushViewController:mapView animated:YES];
}



@end
