//
//  PMWeatherForecastManagerImpl.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMWeatherForecastManager.h"
@protocol PMApiClient;
@protocol PMStorage;

@interface PMWeatherForecastManagerImpl : NSObject <PMWeatherForecastManager>
- (instancetype)initWithSorage:(id<PMStorage>)storage apiClient:(id<PMApiClient>)apiClient;
@end
