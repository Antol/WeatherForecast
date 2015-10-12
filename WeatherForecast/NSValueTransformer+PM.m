//
//  NSValueTransformer+PM.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "NSValueTransformer+PM.h"
#import <Mantle.h>

@implementation NSValueTransformer (PM)

+ (instancetype)PM_currentDateHoursTransformer
{
    static NSValueTransformer *dateTransformer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"hh:mm a";
        dateTransformer = [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            NSDate *date = [dateFormatter dateFromString:value];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *componentsTime = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
            NSDateComponents *componentsDate = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
            componentsTime.year = componentsDate.year;
            componentsTime.month = componentsDate.month;
            componentsTime.day = componentsDate.day;
            componentsTime.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            return [calendar dateFromComponents:componentsTime];
        } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            return [dateFormatter stringFromDate:value];
        }];
    });
    return dateTransformer;
}



@end
