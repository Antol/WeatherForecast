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
    PMCondition *condition = [MTLJSONAdapter modelOfClass:[PMConditionWWO class]
                                       fromJSONDictionary:responceJson
                                                    error:&error];
    expect(condition).toNot.beNil();
    expect(error).to.beNil();
    if (error) {
        NSLog(@"================> %@", error);
    }
    
    expect(condition.date).toNot.beNil();
//    expect(condition.temperatureC).toNot.beNil();
}

@end



