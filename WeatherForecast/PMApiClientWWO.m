//
//  PMApiClientWWO.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMApiClientWWO.h"

@implementation PMApiClientWWO

- (RACSignal *)serchPlaceByName:(NSString *)name
{
    return [RACSignal error:[NSError errorWithDomain:@"Not implemented!" code:0 userInfo:nil]];
}

- (RACSignal *)getWeatherForecastForPlace:(PMPlace *)place
{
    return [RACSignal error:[NSError errorWithDomain:@"Not implemented!" code:0 userInfo:nil]];
}

@end
