//
//  PMWeatherForecastTest.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "PMWeatherForecast.h"
#import "PMCondition.h"
#import "PMPlace.h"

@interface PMWeatherForecastTest : XCTestCase
@property (nonatomic, strong) PMWeatherForecast *forecast;
@end

@implementation PMWeatherForecastTest

- (void)setUp
{
    [super setUp];
    self.forecast = [PMWeatherForecast new];
}

- (void)testWeatherForecastExists
{
    expect(self.forecast).toNot.beNil();
}

- (void)testWeatherForecastHasCurrentCondition
{
    PMCondition *condition = [PMCondition new];
    self.forecast.currentCondition = condition;
    expect(self.forecast.currentCondition).to.equal(condition);
}

- (void)testWeatherForecastHasDailyForecastConditions
{
    NSArray *forecastConditions = @[[PMCondition new], [PMCondition new], [PMCondition new]];
    self.forecast.dailyForecastConditions = forecastConditions;
    expect(self.forecast.dailyForecastConditions.count).to.equal(3);
}

- (void)testWeatherForecastHasPlace
{
    PMPlace *place = [PMPlace new];
    self.forecast.place = place;
    expect(self.forecast.place).to.equal(place);
}

@end


