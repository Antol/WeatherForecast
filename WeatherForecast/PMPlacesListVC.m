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
#import "PMWeatherForecastManager.h"
#import "PMWeatherForecast.h"
#import "PMCondition.h"
#import "PMSearchVC.h"

@interface PMPlacesListVC () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *forecastsForPlaces;
@end

@implementation PMPlacesListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.forecastManager activate];
    
    @weakify(self);
    [RACObserve(self.forecastManager, forecasts) subscribeNext:^(id x) {
        @strongify(self);
        self.forecastsForPlaces = x;
        [self.tableView reloadData];
    }];
}

#pragma mark - Navigation

- (IBAction)prepareForUnwind:(UIStoryboardSegue *)segue
{
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.forecastsForPlaces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMPlaceTableViewCell *cell = [tableView dequeueReusableCellForClass:[PMPlaceTableViewCell class] indexPath:indexPath];
    PMWeatherForecast *forecast = [self.forecastsForPlaces objectAtIndex:indexPath.row];
    cell.textLabel.text = forecast.place.name;
    cell.detailTextLabel.text = [forecast.currentCondition.temperatureC description];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PMPlace *deletePlace = [[self.forecastsForPlaces objectAtIndex:indexPath.row] place];
        @weakify(self);
        [[self.forecastManager removePlace:deletePlace] subscribeError:^(NSError *error) {
            @strongify(self);
            [self showAlertWithMessage:error.domain];
        }];
    }
}

#pragma mark - Private

- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end


