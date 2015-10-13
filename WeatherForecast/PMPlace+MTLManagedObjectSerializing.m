//
//  PMPlace+MTLManagedObjectSerializing.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMPlace+MTLManagedObjectSerializing.h"
#import "PMPlaceEntity.h"

@implementation PMPlace (MTLManagedObjectSerializing)

+ (NSString *)managedObjectEntityName
{
    return [PMPlaceEntity entityName];
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{PMSelectorString(name) : PMSelectorString(name),
             PMSelectorString(region) : PMSelectorString(region),
             PMSelectorString(country) : PMSelectorString(country),
             PMSelectorString(latitude) : PMSelectorString(latitude),
             PMSelectorString(longitude) : PMSelectorString(longitude),
             PMSelectorString(query) : PMSelectorString(query)};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing
{
    return [NSSet setWithObject:PMSelectorString(name)];
}


@end
