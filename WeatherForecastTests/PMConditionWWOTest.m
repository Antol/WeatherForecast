//
//  PMConditionWWOTest.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "PMConditionWWO.h"
#import "PMConditionWWOCurrent.h"

@interface PMConditionWWOTest : XCTestCase
@end

@implementation PMConditionWWOTest

- (void)setUp
{
    [super setUp];
}

- (void)testMappingEmplyJson
{
    NSDictionary *responceJson = @{};
    NSError *error = nil;
    PMCondition *condition = [MTLJSONAdapter modelOfClass:[PMConditionWWO class]
                                       fromJSONDictionary:responceJson
                                                    error:&error];
    expect(condition.date).to.beNil();
}

- (void)testMappingCurrentCondition
{
    NSDictionary *responceJson = @{
        @"cloudcover": @"50",
        @"humidity": @"93",
        @"observation_time": @"08:41 AM",
        @"precipMM": @"0.0",
        @"pressure": @"1024",
        @"temp_C": @"7",
        @"temp_F": @"45",
        @"visibility": @"10",
        @"weatherCode": @"116",
        @"weatherDesc": @[
            @{
                @"value": @"Partly Cloudy"
            }
        ],
        @"weatherIconUrl": @[
            @{
                @"value": @"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png"
            }
        ],
        @"winddir16Point": @"NW",
        @"winddirDegree": @"310",
        @"windspeedKmph": @"15",
        @"windspeedMiles": @"9"
    };
    
    NSError *error = nil;
    PMCondition *condition = [MTLJSONAdapter modelOfClass:[PMConditionWWOCurrent class]
                                       fromJSONDictionary:responceJson
                                                    error:&error];
    expect(condition).toNot.beNil();
    expect(error).to.beNil();
    if (error) {
        NSLog(@"================> %@", error);
    }
    
    expect(condition.date).toNot.beNil();
    
    expect(condition.temperatureC).to.equal(@7);
    expect(condition.temperatureF).to.equal(@45);
    
    expect(condition.windSpeedKmph).to.equal(@15);
    expect(condition.windDirectionDegree).to.equal(@310);
    expect(condition.windDirectionDescription).to.equal(@"NW");
    
    expect(condition.weatherCode).to.equal(@116);
    expect(condition.weatherDescription).to.equal(@"Partly Cloudy");
    expect(condition.weatherIconUrl).toNot.beNil();
    expect(condition.weatherIconUrl).to.equal([NSURL URLWithString:@"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png"]);
    
    expect(condition.precipitationMm).to.equal(@0);
    expect(condition.humidityPercentage).to.equal(@93);
    expect(condition.pressureMilibars).to.equal(@1024);
}

- (void)testMappingForecastCondition
{
    NSDictionary *responceJson = @{
        @"date": @"2015-10-12",
        @"precipMM": @"0.1",
        @"tempMaxC": @"13",
        @"tempMaxF": @"56",
        @"tempMinC": @"6",
        @"tempMinF": @"43",
        @"weatherCode": @"116",
        @"weatherDesc": @[
            @{
                @"value": @"Partly Cloudy"
            }
        ],
        @"weatherIconUrl": @[
            @{
                @"value": @"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png"
            }
        ],
        @"winddir16Point": @"N",
        @"winddirDegree": @"358",
        @"winddirection": @"N",
        @"windspeedKmph": @"21",
        @"windspeedMiles": @"13"
    };
    
    NSError *error = nil;
    PMCondition *condition = [MTLJSONAdapter modelOfClass:[PMConditionWWO class]
                                       fromJSONDictionary:responceJson
                                                    error:&error];
    expect(condition).toNot.beNil();
    expect(error).to.beNil();
    if (error) {
        NSLog(@"================> %@", error);
    }
    
    expect(condition.date).toNot.beNil();
    
    expect(condition.temperatureMinC).to.equal(@6);
    expect(condition.temperatureMinF).to.equal(@43);
    expect(condition.temperatureMaxC).to.equal(@13);
    expect(condition.temperatureMaxF).to.equal(@56);
    
    expect(condition.windSpeedKmph).to.equal(@21);
    expect(condition.windDirectionDegree).to.equal(@358);
    expect(condition.windDirectionDescription).to.equal(@"N");
    
    expect(condition.weatherCode).to.equal(@116);
    expect(condition.weatherDescription).to.equal(@"Partly Cloudy");
    expect(condition.weatherIconUrl).toNot.beNil();
    expect(condition.weatherIconUrl).to.equal([NSURL URLWithString:@"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png"]);
    
    expect(condition.precipitationMm).to.equal(@0.1f);
    
}

@end



