//
//  PMApiClientWWOTest.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import <Expecta+ReactiveCocoa/Expecta+ReactiveCocoa.h>
#import "PMApiClientWWO.h"

@interface PMApiClientWWOTest : XCTestCase
@end

@implementation PMApiClientWWOTest

static id<PMApiClient> apiClient = nil;

+ (void)setUp
{
    [super setUp];
    apiClient = [[PMApiClientWWO alloc] initWithBaseURL:[NSURL URLWithString:@"http://ya.ru/"]];
}

- (void)testPMApiClientWWOExists
{
    expect(apiClient).toNot.beNil();
}

- (void)testSearchPlaceByName
{
    NSString *placeName = @"Narnia";
    RACSignal *searchSignal = [apiClient serchPlaceByName:placeName];
    expect(searchSignal).to.error();
}

@end
