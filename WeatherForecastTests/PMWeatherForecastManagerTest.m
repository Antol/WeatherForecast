//
//  PMWeatherForecastManagerTest.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "PMWeatherForecastManager.h"
#import "PMServicesAssembly.h"
#import "PMConfigAssembly.h"
#import <TyphoonPatcher.h>
#import "PMPlace.h"
#import "LLReactiveMatchers.h"
#import "PMWeatherForecastManagerImpl.h"
#import "PMWeatherForecast.h"
#import "PMCondition.h"
#import <OCMock.h>
#import "PMStorageCD.h"
#import "PMApiClientWWO.h"

@interface PMWeatherForecastManagerTest : XCTestCase
@property (nonatomic, strong) PMWeatherForecastManagerImpl *forecastManager;
@property (nonatomic, strong) PMWeatherForecast *forecast;
@property (nonatomic, strong) PMPlace *place;

@property (nonatomic, strong) id<PMStorage> storageMock;
@property (nonatomic, strong) id<PMApiClient> apiClientMock;
@end

@implementation PMWeatherForecastManagerTest

- (void)setUp
{
    [super setUp];
    self.place = [self place];
    self.forecast = [self forecastWithPlace:self.place];
    
    self.storageMock = OCMClassMock([PMStorageCD class]);
    OCMStub([self.storageMock getAllObjectsForClass:[PMPlace class]]).andReturn([RACSignal return:@[self.place]]);
    
    self.apiClientMock = OCMClassMock([PMApiClientWWO class]);
    OCMStub([self.apiClientMock getWeatherForecastForPlace:self.place]).andReturn([[RACSignal return:self.forecast] delay:1]);
    
    PMServicesAssembly *assembly = [[PMServicesAssembly assembly] activateWithCollaboratingAssemblies:@[[PMConfigAssembly assembly]]];
    TyphoonPatcher *patcher = [[TyphoonPatcher alloc] init];
    [patcher patchDefinitionWithSelector:@selector(storage) withObject:^id{
        return self.storageMock;
    }];
    [patcher patchDefinitionWithSelector:@selector(apiClient) withObject:^id{
        return self.apiClientMock;
    }];
    
    [assembly attachPostProcessor:patcher];
    
    self.forecastManager = [assembly forecastManager];
}

- (void)testWeatherForecastManagerExists
{
    expect(self.forecastManager).toNot.beNil();
}

- (void)testForecastManagerHasOneForecast
{
    RACSignal *forecastsSignal = RACObserve(self.forecastManager, forecasts);
    
    expect(forecastsSignal).will.sendValues(@[[NSNull null], @[self.forecast]]);
    
    OCMVerify([self.storageMock getAllObjectsForClass:[PMPlace class]]);
    OCMVerify([self.apiClientMock getWeatherForecastForPlace:self.place]);
}

#pragma mark - Private

- (PMPlace *)place
{
    PMPlace *place = [PMPlace new];
    place.name = @"Hell";
    place.query = @"Hell";
    return place;
}

- (PMWeatherForecast *)forecastWithPlace:(PMPlace *)place
{
    PMCondition *condition = [self condition];
    PMWeatherForecast *forecast = [PMWeatherForecast new];
    forecast.place = place;
    forecast.currentCondition = condition;
    forecast.dailyForecastConditions = @[[condition copy],[condition copy],[condition copy]];
    return forecast;
}

- (PMCondition *)condition
{
    PMCondition *condition = [PMCondition new];
    condition.temperatureC = @1;
    condition.windDirection = PMWindDirectionE;
    condition.windSpeedKmph = @20;
    condition.date = [NSDate date];
    return condition;
}

@end


