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

@interface PMPlaceVC ()
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureMinMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *precipitationLabel;
@end

@implementation PMPlaceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    @weakify(self);
    [RACObserve(self, forecast) subscribeNext:^(PMWeatherForecast *forecast) {
        @strongify(self);
        self.title = forecast.place.name;
        self.weatherDescriptionLabel.text = forecast.currentCondition.weatherDescription;
        self.temperatureLabel.text = [NSString stringWithFormat:@"%@°C", forecast.currentCondition.temperatureC];
        PMCondition *todayForecast = forecast.dailyForecastConditions.firstObject;
        self.temperatureMinMaxLabel.text = [NSString stringWithFormat:@"%@° / %@°", todayForecast.temperatureMaxC, todayForecast.temperatureMinC];
        self.windSpeedLabel.text = [NSString stringWithFormat:@"%@ Kmph", forecast.currentCondition.windSpeedKmph];
        self.windDirectionLabel.text = forecast.currentCondition.windDirectionDescription;
        self.humidityLabel.text = [NSString stringWithFormat:@"%@ %%", forecast.currentCondition.humidityPercentage];
        self.precipitationLabel.text = [NSString stringWithFormat:@"%@ mm", forecast.currentCondition.precipitationMm];;
    }];
}

@end
