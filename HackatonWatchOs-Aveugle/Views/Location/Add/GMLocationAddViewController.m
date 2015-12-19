//
//  GMLocationAddViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 19/12/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "GMLocationAddViewController.h"

@interface GMLocationAddViewController ()
{
    @private
    NSArray * resultsGoogle;
}

@property (weak, nonatomic) IBOutlet UISearchBar * searchBar;
@property (weak, nonatomic) IBOutlet UITableView * tableView;

@end

@implementation GMLocationAddViewController

- (instancetype)init
{
    if (self = [super init]) {
        resultsGoogle = [NSArray new];
        
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
    NSLog(@"User write : %@", searchText);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return resultsGoogle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UITableViewDelegate

@end
