//
//  PMApiClientWWO.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMApiClientWWO.h"
#import <RACAFNetworking.h>
#import "PMPlace.h"

@implementation PMApiClientWWO

- (instancetype)initWithBaseURL:(NSURL *)baseUrl
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (RACSignal *)serchPlaceByName:(NSString *)name
{
    PMPlace *place = [PMPlace new];
    place.name = name;
    return [[RACSignal return:place] delay:0.5];
}

- (RACSignal *)getWeatherForecastForPlace:(PMPlace *)place
{
    return [RACSignal error:[NSError errorWithDomain:@"Not implemented!" code:0 userInfo:nil]];
}

@end
