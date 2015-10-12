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


@interface PMPlaceTest : XCTestCase
@property (nonatomic, strong) PMPlace *place;
@end

@implementation PMPlaceTest

- (void)setUp
{
    [super setUp];
    self.place = [PMPlace new];
}

- (void)testPlaceExist
{
    expect(self.place).toNot.beNil;
}

- (void)testPlaceHasNameAndQuery
{
    NSString *cityName = @"Dublin";
    self.place.name = cityName;
    self.place.query = cityName;

    expect(self.place.name).to.equal(cityName);
    expect(self.place.query).to.equal(cityName);
}

@end
