//
//  PMWeatherForecastWWOTest.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "PMWeatherForecastWWO.h"
#import "PMWeatherForecast.h"
#import "PMPlace.h"
#import "PMCondition.h"

@interface PMWeatherForecastWWOTest : XCTestCase
@end

@implementation PMWeatherForecastWWOTest

- (void)testMappingWeatherForecast
{
    NSDictionary *responseJson = @{
        @"data": @{
            @"current_condition": @[
                @{
                    @"cloudcover": @"25",
                    @"humidity": @"87",
                    @"observation_time": @"08:26 PM",
                    @"precipMM": @"0.0",
                    @"pressure": @"1027",
                    @"temp_C": @"5",
                    @"temp_F": @"41",
                    @"visibility": @"10",
                    @"weatherCode": @"116",
                    @"weatherDesc": @[
                        @{
                            @"value": @"Partly Cloudy"
                        }
                    ],
                    @"weatherIconUrl": @[
                        @{
                            @"value": @"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png"
                        }
                    ],
                    @"winddir16Point": @"NNW",
                    @"winddirDegree": @"340",
                    @"windspeedKmph": @"13",
                    @"windspeedMiles": @"8"
                }
            ],
            @"request": @[
                @{
                    @"query": @"Dublin, Ireland",
                    @"type": @"City"
                }
            ],
            @"weather": @[
                @{
                    @"date": @"2015-10-12",
                    @"precipMM": @"0.0",
                    @"tempMaxC": @"14",
                    @"tempMaxF": @"57",
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
                    @"winddir16Point": @"NNW",
                    @"winddirDegree": @"332",
                    @"winddirection": @"NNW",
                    @"windspeedKmph": @"17",
                    @"windspeedMiles": @"10"
                },
                @{
                    @"date": @"2015-10-13",
                    @"precipMM": @"0.0",
                    @"tempMaxC": @"13",
                    @"tempMaxF": @"56",
                    @"tempMinC": @"4",
                    @"tempMinF": @"38",
                    @"weatherCode": @"119",
                    @"weatherDesc": @[
                        @{
                            @"value": @"Cloudy"
                        }
                    ],
                    @"weatherIconUrl": @[
                        @{
                            @"value": @"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0003_white_cloud.png"
                        }
                    ],
                    @"winddir16Point": @"NE",
                    @"winddirDegree": @"53",
                    @"winddirection": @"NE",
                    @"windspeedKmph": @"14",
                    @"windspeedMiles": @"9"
                },
                @{
                    @"date": @"2015-10-14",
                    @"precipMM": @"0.0",
                    @"tempMaxC": @"14",
                    @"tempMaxF": @"57",
                    @"tempMinC": @"6",
                    @"tempMinF": @"44",
                    @"weatherCode": @"119",
                    @"weatherDesc": @[
                        @{
                            @"value": @"Cloudy"
                        }
                    ],
                    @"weatherIconUrl": @[
                        @{
                            @"value": @"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0003_white_cloud.png"
                        }
                    ],
                    @"winddir16Point": @"SE",
                    @"winddirDegree": @"145",
                    @"winddirection": @"SE",
                    @"windspeedKmph": @"6",
                    @"windspeedMiles": @"4"
                },
                @{
                    @"date": @"2015-10-15",
                    @"precipMM": @"0.0",
                    @"tempMaxC": @"14",
                    @"tempMaxF": @"57",
                    @"tempMinC": @"8",
                    @"tempMinF": @"47",
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
                    @"winddir16Point": @"NNW",
                    @"winddirDegree": @"331",
                    @"winddirection": @"NNW",
                    @"windspeedKmph": @"11",
                    @"windspeedMiles": @"7"
                },
                @{
                    @"date": @"2015-10-16",
                    @"precipMM": @"1.0",
                    @"tempMaxC": @"13",
                    @"tempMaxF": @"56",
                    @"tempMinC": @"10",
                    @"tempMinF": @"49",
                    @"weatherCode": @"176",
                    @"weatherDesc": @[
                        @{
                            @"value": @"Patchy rain nearby"
                        }
                    ],
                    @"weatherIconUrl": @[
                        @{
                            @"value": @"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0009_light_rain_showers.png"
                        }
                    ],
                    @"winddir16Point": @"NE",
                    @"winddirDegree": @"46",
                    @"winddirection": @"NE",
                    @"windspeedKmph": @"21",
                    @"windspeedMiles": @"13"
                }
            ]
        }
    };
    
    NSError *error = nil;
    PMWeatherForecast *forecast = [MTLJSONAdapter modelOfClass:[PMWeatherForecastWWO class]
                                            fromJSONDictionary:responseJson
                                                         error:&error];
    expect(forecast).toNot.beNil();
    expect(error).to.beNil();
    if (error) {
        NSLog(@"================> %@", error);
    }
    
    expect(forecast.place).toNot.beNil();
    expect(forecast.place.query).to.equal(@"Dublin, Ireland");
    
    expect(forecast.currentCondition).toNot.beNil();
    expect(forecast.currentCondition.temperatureC).to.equal(@5);
    
    expect(forecast.dailyForecastConditions).toNot.beNil();
    expect(forecast.dailyForecastConditions.count).to.equal(5);
}

@end


