//
//  PMApiClient.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RACSignal;
@class PMPlace;

@protocol PMApiClient <NSObject>

- (RACSignal *)searchPlaceByName:(NSString *)name;
- (RACSignal *)getWeatherForecastForPlace:(PMPlace *)place;

@end
