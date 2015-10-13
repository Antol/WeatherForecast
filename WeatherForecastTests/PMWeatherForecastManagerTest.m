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
@property (nonatomic, strong) PMWeatherForecast *forecast2;
@property (nonatomic, strong) PMPlace *place;
@property (nonatomic, strong) PMPlace *place2;

@property (nonatomic, strong) id<PMStorage> storageMock;
@property (nonatomic, strong) id<PMApiClient> apiClientMock;
@end

@implementation PMWeatherForecastManagerTest

- (void)setUp
{
    [super setUp];
    self.place = [self createPlace];
    self.place2 = [self createPlace2];
    self.forecast = (id)@"1";//[self forecastWithPlace:self.place];
    self.forecast2 = (id)@"2";//[self forecastWithPlace:self.place2];
    
    self.storageMock = OCMClassMock([PMStorageCD class]);
    OCMStub([self.storageMock getAllObjectsForClass:[PMPlace class]]).andReturn([RACSignal return:@[self.place]]);
    OCMStub([self.storageMock saveObjects:@[self.place2]]);
    
    self.apiClientMock = OCMClassMock([PMApiClientWWO class]);
    OCMStub([self.apiClientMock getWeatherForecastForPlace:self.place]).andReturn([RACSignal return:self.forecast]);
    OCMStub([self.apiClientMock getWeatherForecastForPlace:self.place2]).andReturn([RACSignal return:self.forecast2]);
    
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

- (void)testGetForecasts
{
    RACSignal *forecastsSignal = [RACObserve(self.forecastManager, forecasts) ignore:nil];
    
    expect(forecastsSignal).will.sendValues(@[@[self.forecast]]);
    
    OCMVerify([self.storageMock getAllObjectsForClass:[PMPlace class]]);
    OCMVerify([self.apiClientMock getWeatherForecastForPlace:self.place]);
}

- (void)testAddPlace
{
    RACSignal *forecastsSignal = [[[RACObserve(self.forecastManager, forecasts) ignore:nil] skip:1] take:1];
    
    [[self.forecastManager addPlace:self.place2] subscribeError:^(NSError *error) {
        failure(@"This should not happen");
    }];
    
    expect(forecastsSignal).after(10).sendValues(@[@[self.forecast, self.forecast2]]);
    
    OCMVerify([self.storageMock saveObjects:[OCMArg any]]);
    OCMVerify([self.apiClientMock getWeatherForecastForPlace:self.place2]);
}

#pragma mark - Private

- (PMPlace *)createPlace
{
    PMPlace *place = [PMPlace new];
    place.name = @"Hell";
    place.query = @"Hell";
    return place;
}

- (PMPlace *)createPlace2
{
    PMPlace *place = [PMPlace new];
    place.name = @"Heaven";
    place.query = @"Heaven";
    return place;
}

- (PMWeatherForecast *)createForecastWithPlace:(PMPlace *)place
{
    PMCondition *condition = [self createCondition];
    PMWeatherForecast *forecast = [PMWeatherForecast new];
    forecast.place = place;
    forecast.currentCondition = condition;
    forecast.dailyForecastConditions = @[[condition copy],[condition copy],[condition copy]];
    return forecast;
}

- (PMCondition *)createCondition
{
    PMCondition *condition = [PMCondition new];
    condition.temperatureC = @1;
    condition.windDirection = PMWindDirectionE;
    condition.windSpeedKmph = @20;
    condition.date = [NSDate date];
    return condition;
}

@end


