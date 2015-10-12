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
    return @{
        PMSelectorString(date): @"date",
        PMSelectorString(temperatureC): @"temp_C",
        PMSelectorString(temperatureF): @"temp_F",
        PMSelectorString(temperatureMinC): @"tempMinC",
        PMSelectorString(temperatureMinF): @"tempMinF",
        PMSelectorString(temperatureMaxC): @"tempMaxC",
        PMSelectorString(temperatureMaxF): @"tempMaxF",
        PMSelectorString(windSpeedKmph): @"windspeedKmph",
        PMSelectorString(windDirectionDegree): @"winddirDegree",
        PMSelectorString(windDirectionDescription): @"winddir16Point",
        PMSelectorString(weatherCode): @"weatherCode",
        PMSelectorString(weatherDescription): @"weatherDesc",
        PMSelectorString(weatherIconUrl): @"weatherIconUrl",
        PMSelectorString(precipitationMm): @"precipMM",
        PMSelectorString(humidityPercentage): @"humidity",
        PMSelectorString(pressureMilibars): @"pressure",
    };
}

+ (id)dateJSONTransformer
{
    return [NSValueTransformer PM_dateAndTimeTransformer];
}

+ (id)temperatureCJSONTransformer{    return [NSValueTransformer PM_stringToNumberTransformer]; }
+ (id)temperatureFJSONTransformer{    return [NSValueTransformer PM_stringToNumberTransformer]; }
+ (id)temperatureMinCJSONTransformer{ return [NSValueTransformer PM_stringToNumberTransformer]; }
+ (id)temperatureMinFJSONTransformer{ return [NSValueTransformer PM_stringToNumberTransformer]; }
+ (id)temperatureMaxCJSONTransformer{ return [NSValueTransformer PM_stringToNumberTransformer]; }
+ (id)temperatureMaxFJSONTransformer{ return [NSValueTransformer PM_stringToNumberTransformer]; }

+ (id)windSpeedKmphJSONTransformer{       return [NSValueTransformer PM_stringToNumberTransformer]; }
+ (id)windDirectionDegreeJSONTransformer{ return [NSValueTransformer PM_stringToNumberTransformer]; }

+ (id)weatherCodeJSONTransformer{        return [NSValueTransformer PM_stringToNumberTransformer]; }
+ (id)precipitationMmJSONTransformer{    return [NSValueTransformer PM_stringToNumberTransformer]; }
+ (id)humidityPercentageJSONTransformer{ return [NSValueTransformer PM_stringToNumberTransformer]; }
+ (id)pressureMilibarsJSONTransformer{   return [NSValueTransformer PM_stringToNumberTransformer]; }

+ (id)weatherDescriptionJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *weatherDesc, BOOL *success, NSError *__autoreleasing *error) {
        return [[weatherDesc firstObject] valueForKey:@"value"];
    }];
}

+ (id)weatherIconUrlJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *weatherIconUrl, BOOL *success, NSError *__autoreleasing *error) {
        NSString *urlString = [[weatherIconUrl firstObject] valueForKey:@"value"];
        return [NSURL URLWithString:urlString];
    }];
}

@end
