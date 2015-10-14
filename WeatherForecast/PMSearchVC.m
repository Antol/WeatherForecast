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
#import "PMSearchErrorTableViewCell.h"

static NSString *const kUnwindToPMPlacesListVC = @"UnwindToPMPlacesListVC";

@interface PMSearchVC () <UISearchControllerDelegate, UISearchResultsUpdating>
@property (strong, nonatomic) UISearchController *searchController;

@property (nonatomic, strong) NSArray *places;
@property (nonatomic, strong) NSString *errorMessage;

@property (nonatomic, strong) PMPlace *selectedPlace;
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
    
    self.errorMessage = @"Empty";
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.places.count;
    if (count == 0) {
        count = 1;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.places.count == 0) {
        PMSearchErrorTableViewCell *cell = [tableView dequeueReusableCellForClass:[PMSearchErrorTableViewCell class] indexPath:indexPath];
        cell.textLabel.text = self.errorMessage;
        return cell;
    }
    
    PMSearchTableViewCell *cell = [tableView dequeueReusableCellForClass:[PMSearchTableViewCell class] indexPath:indexPath];
    PMPlace *place = [self.places objectAtIndex:indexPath.row];
    cell.textLabel.text = place.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", place.region, place.country];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedPlace = [self.places objectAtIndex:indexPath.row];
    
    if (self.searchController.isActive) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self performSegueWithIdentifier:kUnwindToPMPlacesListVC sender:self];
        }];
    }
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
    } error:^(NSError *error) {
        @strongify(self);
        self.places = nil;
        self.errorMessage = error.domain;
        [self.tableView reloadData];
    }];
}

@end


