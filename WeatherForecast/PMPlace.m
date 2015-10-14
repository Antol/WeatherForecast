//
//  PMPlace.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMPlace.h"

@implementation PMPlace

- (NSString *)query
{
    if (!_query) {
        return [NSString stringWithFormat:@"%@, %@, %@", self.name, self.region, self.country];
    }
    return _query;
}

@end
