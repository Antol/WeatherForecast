//
//  PMSearchVC.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMSearchVC.h"
#import "PMNibManagement.h"
#import "PMSearchTableViewCell.h"
#import "PMPlace.h"
#import "PMApiClient.h"

@interface PMSearchVC () <UISearchResultsUpdating>
@property (strong, nonatomic) UISearchController *searchController;

@property (nonatomic, strong) NSArray *places;
@end

@implementation PMSearchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.searchController.searchBar sizeToFit];
    
    self.definesPresentationContext = YES;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMSearchTableViewCell *cell = [tableView dequeueReusableCellForClass:[PMSearchTableViewCell class] indexPath:indexPath];
    PMPlace *place = [self.places objectAtIndex:indexPath.row];
    cell.textLabel.text = place.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", place.region, place.country];
    return cell;
}

#pragma mark - UISearchController

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    @weakify(self);
    [[self.apiClient searchPlaceByName:searchString] subscribeNext:^(id x) {
        @strongify(self);
        self.places = x;
        [self.tableView reloadData];
    }];
    [self.tableView reloadData];
}

@end
