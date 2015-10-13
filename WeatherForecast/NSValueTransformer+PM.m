//
//  NSValueTransformer+PM.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "NSValueTransformer+PM.h"
#import <Mantle.h>
#import "PMCondition.h"

@implementation NSValueTransformer (PM)

+ (instancetype)PM_dateAndTimeTransformer
{
    static NSValueTransformer *dateTransformer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        timeFormatter.dateFormat = @"hh:mm a";
        timeFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        dateTransformer = [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            NSDate *time = [timeFormatter dateFromString:value]?:[NSDate dateWithTimeIntervalSince1970:0];
            NSDate *date = [dateFormatter dateFromString:value]?:[NSDate date];
            NSDateComponents *componentsTime = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:time];
            NSDateComponents *componentsDate = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
            componentsDate.hour = componentsTime.hour;
            componentsDate.minute = componentsTime.minute;
            return [calendar dateFromComponents:componentsDate];
        } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            return [dateFormatter stringFromDate:value];
        }];
    });
    return dateTransformer;
}

+ (instancetype)PM_stringToNumberTransformer
{
    static NSValueTransformer *transformer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        transformer = [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            return [numberFormatter numberFromString:value];
        } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            return [numberFormatter stringFromNumber:value];
        }];
    });
    return transformer;
}

+ (instancetype)PM_windDirectionTransformer
{
    static NSValueTransformer *transformer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *mapping = @{
            @"N":   @(PMWindDirectionN),
            @"NNE": @(PMWindDirectionNNE),
            @"NE":  @(PMWindDirectionNE),
            @"ENE": @(PMWindDirectionENE),
            @"E":   @(PMWindDirectionE),
            @"ESE": @(PMWindDirectionESE),
            @"SE":  @(PMWindDirectionSE),
            @"SSE": @(PMWindDirectionSSE),
            @"S":   @(PMWindDirectionS),
            @"SSW": @(PMWindDirectionSSW),
            @"SW":  @(PMWindDirectionSW),
            @"WSW": @(PMWindDirectionWSW),
            @"W":   @(PMWindDirectionW),
            @"WNW": @(PMWindDirectionWNW),
            @"NW":  @(PMWindDirectionNW),
            @"NNW": @(PMWindDirectionNNW),
        };
        
        transformer = [NSValueTransformer mtl_valueMappingTransformerWithDictionary:mapping
                                                                       defaultValue:@(PMWindDirectionUnknown)
                                                                reverseDefaultValue:nil];
    });
    return transformer;
}

+ (instancetype)PM_arrayWithSingleValueDictionaryTransformer
{
    static NSValueTransformer *transformer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transformer = [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *values, BOOL *success, NSError *__autoreleasing *error) {
            return [[values firstObject] valueForKey:@"value"];
        }];
    });
    return transformer;
}

@end


