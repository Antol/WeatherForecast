//
//  NSValueTransformerTest.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "NSValueTransformer+PM.h"

@interface NSValueTransformerTest : XCTestCase
@end

static NSCalendar *calendar = nil;

@implementation NSValueTransformerTest

+ (void)setUp
{
    [super setUp];
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
}

- (void)testDateAndTimeTransformerExists
{
    NSValueTransformer *transformer = [NSValueTransformer PM_dateAndTimeTransformer];
    expect(transformer).toNot.beNil();
}

- (void)testTransformHoursStringToCurrentDate_8_41_am_00
{
    NSString *hoursString = @"08:41 AM";
    NSDate *now = [NSDate date];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    components.hour = 8;
    components.minute = 41;
    NSDate *today_8_41_am_00 = [calendar dateFromComponents:components];
    
    NSValueTransformer *transformer = [NSValueTransformer PM_dateAndTimeTransformer];
    NSDate *date = [transformer transformedValue:hoursString];
    
    expect(date).toNot.beNil();
    expect(date).to.equal(today_8_41_am_00);
}

- (void)testTransformHoursStringToCurrentDate_8_41_pm_00
{
    NSString *hoursString = @"08:41 PM";
    NSDate *now = [NSDate date];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    components.hour = 20;
    components.minute = 41;
    NSDate *today_8_41_pm_00 = [calendar dateFromComponents:components];
    
    NSValueTransformer *transformer = [NSValueTransformer PM_dateAndTimeTransformer];
    NSDate *date = [transformer transformedValue:hoursString];
    
    expect(date).toNot.beNil();
    expect(date).to.equal(today_8_41_pm_00);
}

- (void)testTransformDateString
{
    NSString *dateString = @"2015-10-12";
    NSDateComponents *components = [NSDateComponents new];
    components.year = 2015;
    components.month = 10;
    components.day = 12;
    NSDate *expectedDate = [calendar dateFromComponents:components];
    
    NSValueTransformer *transformer = [NSValueTransformer PM_dateAndTimeTransformer];
    NSDate *date = [transformer transformedValue:dateString];
    
    expect(date).to.equal(expectedDate);
}

- (void)testStringToNumberTransformerExists
{
    NSValueTransformer *transformer = [NSValueTransformer PM_stringToNumberTransformer];
    expect(transformer).toNot.beNil();
}

- (void)testStringToNumberTransformation
{
    NSValueTransformer *transformer = [NSValueTransformer PM_stringToNumberTransformer];
    expect([transformer transformedValue:@"2"]).to.equal(@2);
    expect([transformer transformedValue:@"2.5"]).to.equal(@2.5f);
    expect([transformer transformedValue:@"-2.5"]).to.equal(@(-2.5f));
}

@end


