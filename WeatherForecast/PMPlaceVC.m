//
//  PMPlaceVC.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMPlaceVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PMWeatherForecast.h"
#import "PMPlace.h"
#import "PMCondition.h"
#import "PMDailyForecastTableViewCell.h"
#import "PMNibManagement.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface PMPlaceVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureMinMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *precipitationLabel;

@property (nonatomic, strong) NSArray *futureDaysConditions;
@end

@implementation PMPlaceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    @weakify(self);
    [RACObserve(self, forecast) subscribeNext:^(PMWeatherForecast *forecast) {
        @strongify(self);
        self.title = forecast.place.name;
        [self.iconImageView setImageWithURL:forecast.currentCondition.weatherIconUrl];
        self.weatherDescriptionLabel.text = forecast.currentCondition.weatherDescription;
        self.temperatureLabel.text = [NSString stringWithFormat:@"%@°C", forecast.currentCondition.temperatureC];
        PMCondition *todayForecast = forecast.dailyForecastConditions.firstObject;
        self.temperatureMinMaxLabel.text = [NSString stringWithFormat:@"%@° / %@°", todayForecast.temperatureMaxC, todayForecast.temperatureMinC];
        self.windSpeedLabel.text = [NSString stringWithFormat:@"%@ Kmph", forecast.currentCondition.windSpeedKmph];
        self.windDirectionLabel.text = forecast.currentCondition.windDirectionDescription;
        self.humidityLabel.text = [NSString stringWithFormat:@"%@ %%", forecast.currentCondition.humidityPercentage];
        self.precipitationLabel.text = [NSString stringWithFormat:@"%@ mm", forecast.currentCondition.precipitationMm];
        
        self.futureDaysConditions = forecast.dailyForecastConditions;
    }];
    
    [RACObserve(self, futureDaysConditions) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.futureDaysConditions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMDailyForecastTableViewCell *cell = [tableView dequeueReusableCellForClass:[PMDailyForecastTableViewCell class] indexPath:indexPath];
    cell.condition = [self.futureDaysConditions objectAtIndex:indexPath.row];
    return cell;
}

@end


