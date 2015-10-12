//
//  PMConditionTest.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "PMCondition.h"

@interface PMConditionTest : XCTestCase
@property (nonatomic, strong) PMCondition *condition;
@end

@implementation PMConditionTest

- (void)setUp
{
    [super setUp];
    self.condition = [PMCondition new];
}

- (void)testConditionExists
{
    expect(self.condition).toNot.beNil;
}

- (void)testConditionHasProperties
{
    NSNumber *tempNumber = @1;
    NSDate *tempDate = [NSDate date];
    NSString *tempString = @"temp";
    NSURL *tempUrl = [NSURL URLWithString:@"http://ya.ru/"];
    
    self.condition.date = tempDate;
    
    self.condition.temperatureC = tempNumber;
    self.condition.temperatureF = tempNumber;
    self.condition.temperatureMinC = tempNumber;
    self.condition.temperatureMinF = tempNumber;
    self.condition.temperatureMaxC = tempNumber;
    self.condition.temperatureMaxF = tempNumber;
    
    self.condition.windSpeedKmph = tempNumber;
    self.condition.windDirectionDegree = tempNumber;
    self.condition.windDirectionDescription = tempString;
    
    self.condition.weatherCode = tempNumber;
    self.condition.weatherDescription = tempString;
    self.condition.weatherIconUrl = tempUrl;
    
    self.condition.precipitationMm = tempNumber;
    self.condition.humidityPercentage = tempNumber;
    self.condition.pressureMilibars = tempNumber;
    
    expect(self.condition).toNot.equal(@"Spanish Inquisition");
}

@end


