//
//  PMCondition.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMBaseModel.h"

@interface PMCondition : PMBaseModel
@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSNumber *temperatureC;
@property (nonatomic, strong) NSNumber *temperatureF;
@property (nonatomic, strong) NSNumber *temperatureMinC;
@property (nonatomic, strong) NSNumber *temperatureMinF;
@property (nonatomic, strong) NSNumber *temperatureMaxC;
@property (nonatomic, strong) NSNumber *temperatureMaxF;

@property (nonatomic, strong) NSNumber *windSpeedKmph;
@property (nonatomic, strong) NSNumber *windDirectionDegree;
@property (nonatomic, strong) NSString *windDirectionDescription;

@property (nonatomic, assign) NSNumber *weatherCode;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSURL *weatherIconUrl;

@property (nonatomic, strong) NSNumber *precipitationMm;

@property (nonatomic, strong) NSNumber *humidityPercentage;

@property (nonatomic, strong) NSNumber *pressureMilibars;
@end
