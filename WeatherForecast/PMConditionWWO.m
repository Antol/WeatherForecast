//
//  PMConditionWWO.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMConditionWWO.h"
#import "NSValueTransformer+PM.h"

@implementation PMConditionWWO

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{PMSelectorString(date): @"observation_time"};
}

+ (id)dateJSONTransformer
{
    return [NSValueTransformer PM_currentDateHoursTransformer];
}

@end
