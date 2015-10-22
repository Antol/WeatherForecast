//
//  PMConditionWWOForecast.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMConditionWWOCurrent.h"

@implementation PMConditionWWOCurrent

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSMutableDictionary *mapping = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    [mapping setObject:@"observation_time" forKey:PMSelectorString(date)];
    return mapping;
}

@end
