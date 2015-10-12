//
//  PMCondition.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMBaseModel.h"

typedef NS_ENUM(NSUInteger, PMWindDirection) {
    PMWindDirectionUnknown,
    PMWindDirectionN,
    PMWindDirectionNNE,
    PMWindDirectionNE,
    PMWindDirectionENE,
    PMWindDirectionE,
    PMWindDirectionESE,
    PMWindDirectionSE,
    PMWindDirectionSSE,
    PMWindDirectionS,
    PMWindDirectionSSW,
    PMWindDirectionSW,
    PMWindDirectionWSW,
    PMWindDirectionW,
    PMWindDirectionWNW,
    PMWindDirectionNW,
    PMWindDirectionNNW
};

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
@property (nonatomic, assign) PMWindDirection windDirection;

@property (nonatomic, assign) NSNumber *weatherCode;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSURL *weatherIconUrl;

@property (nonatomic, strong) NSNumber *precipitationMm;

@property (nonatomic, strong) NSNumber *humidityPercentage;

@property (nonatomic, strong) NSNumber *pressureMilibars;
@end
