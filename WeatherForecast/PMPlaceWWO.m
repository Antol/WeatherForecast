//
//  PMPlaceWWO.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMPlaceWWO.h"

@implementation PMPlaceWWO

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{PMSelectorString(query): @"query"};
}

@end
