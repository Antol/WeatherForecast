//
//  PMPlaceWWOTest.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "PMPlaceWWO.h"

@interface PMPlaceWWOTest : XCTestCase
@end

@implementation PMPlaceWWOTest

- (void)testMappingFromWeatherForecast
{
    NSDictionary *responseJson = @{
        @"query": @"Dublin, Ireland",
        @"type": @"City"
    };
    
    NSError *error = nil;
    PMPlace *place = [MTLJSONAdapter modelOfClass:[PMPlaceWWO class]
                                       fromJSONDictionary:responseJson
                                                    error:&error];
    expect(place).toNot.beNil();
    expect(error).to.beNil();
    if (error) {
        NSLog(@"================> %@", error);
    }
}

- (void)testMappingFromSearchPlace
{
    NSDictionary *responseJson = @{
        @"areaName": @[
            @{
                @"value": @"Dublin"
            }
        ],
        @"country": @[
            @{
                @"value": @"Ireland"
            }
        ],
        @"latitude": @"53.333",
        @"longitude": @"-6.249",
        @"population": @"1024027",
        @"region": @[
            @{
                @"value": @"Dublin"
            }
        ],
        @"weatherUrl": @[
            @{
                @"value": @"http://www.worldweatheronline.com/v2/weather.aspx?q=53.3331,-6.2489"
            }
        ]
    };
    
    NSError *error = nil;
    PMPlace *place = [MTLJSONAdapter modelOfClass:[PMPlaceWWO class]
                                   fromJSONDictionary:responseJson
                                                error:&error];
    expect(place).toNot.beNil();
    expect(error).to.beNil();
    if (error) {
        NSLog(@"================> %@", error);
    }
    
    expect(place.name).to.equal(@"Dublin");
    expect(place.region).to.equal(@"Dublin");
    expect(place.country).to.equal(@"Ireland");
    expect(place.latitude).to.equal(@53.333);
    expect(place.longitude).to.equal(@(-6.249));
}

@end
