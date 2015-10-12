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

- (void)testMapping
{
    NSDictionary *responseJson = @{
        @"query": @"Dublin, Ireland",
        @"type": @"City"
    };
    
    NSError *error = nil;
    PMCondition *place = [MTLJSONAdapter modelOfClass:[PMPlaceWWO class]
                                       fromJSONDictionary:responseJson
                                                    error:&error];
    expect(place).toNot.beNil();
    expect(error).to.beNil();
    if (error) {
        NSLog(@"================> %@", error);
    }
}

@end
