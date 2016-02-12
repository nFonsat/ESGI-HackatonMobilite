//
//  GMTypeDangerViewController.m
//  HackatonWatchOs-Aveugle
//
//  Created by Nicolas Fonsat on 07/02/2016.
//  Copyright © 2016 Etudiant. All rights reserved.
//

#import "GMTypeDangerViewController.h"
#import "GMDangerWebAPI.h"

@interface GMTypeDangerViewController ()
{
@private
    NSMutableArray<GMTypeDanger *> * _typesDanger;
    GMDangerWebAPI * _dangerWebAPI;
}

@property (weak, nonatomic) IBOutlet UITableView * tableView;

@end

@implementation GMTypeDangerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dangerWebAPI = [[GMDangerWebAPI alloc]init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    _typesDanger = [NSMutableArray new];
    
    [_dangerWebAPI getTypeDangersSuccess:^(id responseObject)
    {
        for (NSDictionary * dangerTypeJson in responseObject) {
            GMTypeDanger * type = [[GMTypeDanger alloc] initFromJsonDictionary:dangerTypeJson];
            [_typesDanger addObject:type];
        }
        
        [self.tableView reloadData];
    }
                                 Failure:^(AFHTTPRequestOperation * operation, NSError * error)
    {
        [self showErrorNotificationWithMessage:@"Impossible to load type of danger"];
    }];
}

#pragma mark - GMBaseViewController

- (UIColor *)getBarTintColor
{
    return [UIColor dangerColor];
}

- (NSString *)getTitle
{
    return @"Type of Danger";
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _typesDanger.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"HistoryCell"];
    }
    
    GMTypeDanger * type = _typesDanger[indexPath.row];
    
    cell.textLabel.text = type.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMTypeDanger * typeDanger = _typesDanger[indexPath.row];
    [self.delegate userDidChooseTypeDanger:typeDanger];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
