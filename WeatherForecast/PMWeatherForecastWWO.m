//
//  PMWeatherForecastWWO.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMWeatherForecastWWO.h"
#import "PMConditionWWO.h"
#import "PMConditionWWOCurrent.h"
#import "PMPlaceWWO.h"

@implementation PMWeatherForecastWWO

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        PMSelectorString(place): @"data.request",
        PMSelectorString(currentCondition): @"data.current_condition",
        PMSelectorString(dailyForecastConditions): @"data.weather"
    };
}

+ (NSValueTransformer *)placeJSONTransformer
{
    static NSValueTransformer *transformer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transformer = [MTLJSONAdapter dictionaryTransformerWithModelClass:[PMPlaceWWO class]];
    });
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *places, BOOL *success, NSError *__autoreleasing *error) {
        return [transformer transformedValue:places.firstObject];
    }];
}

+ (NSValueTransformer *)currentConditionJSONTransformer
{
    static NSValueTransformer *transformer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transformer = [MTLJSONAdapter dictionaryTransformerWithModelClass:[PMConditionWWOCurrent class]];
    });
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *conditions, BOOL *success, NSError *__autoreleasing *error) {
        return [transformer transformedValue:conditions.firstObject];
    }];
}

+ (NSValueTransformer *)dailyForecastConditionsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[PMConditionWWO class]];
}

@end
