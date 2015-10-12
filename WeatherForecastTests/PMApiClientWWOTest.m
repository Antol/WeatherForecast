//
//  PMApiClientWWOTest.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "LLReactiveMatchers.h"
#import "PMApiClientWWO.h"
#import "PMPlace.h"
#import "PMWeatherForecast.h"
#import "PMServicesAssembly.h"
#import "PMConfigAssembly.h"

@interface PMApiClientWWOTest : XCTestCase
@property (nonatomic, strong) id<PMApiClient> apiClient;
@end

@implementation PMApiClientWWOTest

- (void)setUp
{
    [super setUp];
    PMServicesAssembly* assembly = [[PMServicesAssembly assembly] activateWithCollaboratingAssemblies:@[[PMConfigAssembly assembly]]];
    self.apiClient = [assembly apiClient];
}

- (void)testPMApiClientWWOExists
{
    expect(self.apiClient).toNot.beNil();
}

- (void)testSearchPlaceByName
{
    NSString *placeName = @"Narnia";
    PMPlace *place = [PMPlace new];
    place.name = placeName;
    
    RACSignal *searchSignal = [self.apiClient searchPlaceByName:placeName];
    
    expect(searchSignal).will.sendValues(@[place]);
}

- (void)testGetWeatherForecastForPlace
{
    PMPlace *place = [PMPlace new];
    place.name = @"Dublin";
    place.query = @"Dublin";
    
    RACSignal *forecastSignal = [self.apiClient getWeatherForecastForPlace:place];
    
    expect(forecastSignal).will.matchValue(0, ^BOOL(PMWeatherForecast *forecast){
        return [forecast.place isEqual:place];
    });
}

@end


