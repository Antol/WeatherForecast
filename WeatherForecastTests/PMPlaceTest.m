//
//  PMPlaceTest.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "PMPlace.h"
#import "PMCondition.h"


@interface PMPlaceTest : XCTestCase
@property (nonatomic, strong) PMPlace *place;
@end

@implementation PMPlaceTest

- (void)setUp
{
    [super setUp];
    self.place = [PMPlace new];
}

- (void)testPlaceExists
{
    expect(self.place).toNot.beNil();
}

- (void)testPlaceHasNameAndQuery
{
    NSString *cityName = @"Dublin";
    self.place.name = cityName;
    self.place.query = cityName;

    expect(self.place.name).to.equal(cityName);
    expect(self.place.query).to.equal(cityName);
}

- (void)testPlaceHasCurrentCondition
{
    PMCondition *condition = [PMCondition new];
    self.place.currentCondition = condition;
    expect(self.place.currentCondition).to.equal(condition);
}

- (void)testPlaceHasDailyForecastConditions
{
    NSArray *forecastConditions = @[[PMCondition new], [PMCondition new], [PMCondition new]];
    self.place.dailyForecastConditions = forecastConditions;
    expect(self.place.dailyForecastConditions.count).to.equal(3);
}

@end


