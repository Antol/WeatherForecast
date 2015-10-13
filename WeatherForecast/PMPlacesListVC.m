//
//  PMCitiesListVC.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 11.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMPlacesListVC.h"
#import "PMApiClient.h"
#import "PMStorage.h"
#import "PMPlace.h"
#import "PMNibManagement.h"
#import "PMPlaceTableViewCell.h"

@interface PMPlacesListVC () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *places;
@end

@implementation PMPlacesListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    @weakify(self);
    
    [[[self.storage
        getAllObjectsForClass:[PMPlace class]]
        deliverOn:[RACScheduler mainThreadScheduler] ]
        subscribeNext:^(id x) {
            @strongify(self);
            self.places = x;
            [self.tableView reloadData];
        }];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMPlaceTableViewCell *cell = [tableView dequeueReusableCellForClass:[PMPlaceTableViewCell class] indexPath:indexPath];
    PMPlace *place = [self.places objectAtIndex:indexPath.row];
    cell.textLabel.text = place.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}


@end


