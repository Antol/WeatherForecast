//
//  PMPlaceWWO.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMPlaceWWO.h"
#import "NSValueTransformer+PM.h"

@implementation PMPlaceWWO

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        PMSelectorString(query): @[@"areaName", @"region", @"country", @"query"],
        PMSelectorString(name): @"areaName",
        PMSelectorString(region): @"region",
        PMSelectorString(country): @"country",
        PMSelectorString(latitude): @"latitude",
        PMSelectorString(longitude): @"longitude",
    };
}

+ (id)nameJSONTransformer{ return [NSValueTransformer PM_arrayWithSingleValueDictionaryTransformer]; }
+ (id)regionJSONTransformer{ return [NSValueTransformer PM_arrayWithSingleValueDictionaryTransformer]; }
+ (id)countryJSONTransformer{ return [NSValueTransformer PM_arrayWithSingleValueDictionaryTransformer]; }

+ (id)latitudeJSONTransformer{ return [NSValueTransformer PM_stringToNumberTransformer]; }
+ (id)longitudeJSONTransformer{ return [NSValueTransformer PM_stringToNumberTransformer]; }

+ (id)queryJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *data, BOOL *success, NSError *__autoreleasing *error) {
        if (data.allKeys.count == 0) {
            return nil;
        }
        if ([[data objectForKey:@"query"] length] > 0) {
            return [data objectForKey:@"query"];
        }
        NSValueTransformer *transformer = [NSValueTransformer PM_arrayWithSingleValueDictionaryTransformer];
        NSMutableArray *queryArray = [@[] mutableCopy];
        [queryArray addObject:[transformer transformedValue:[data objectForKey:@"areaName"]]];
        [queryArray addObject:[transformer transformedValue:[data objectForKey:@"region"]]];
        [queryArray addObject:[transformer transformedValue:[data objectForKey:@"country"]]];
        return [queryArray componentsJoinedByString:@", "];
    }];
}

@end
