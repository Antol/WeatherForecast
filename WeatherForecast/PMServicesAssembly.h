//
//  PMServicesAssembly.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <Typhoon/Typhoon.h>
@protocol PMApiClient;
@protocol PMStorage;
@protocol PMWeatherForecastManager;
@class AFHTTPSessionManager;
@class PMStorageCDConfiguration;

@interface PMServicesAssembly : TyphoonAssembly

- (id<PMApiClient>)apiClient;
- (AFHTTPSessionManager *)httpSessionManager;

- (id<PMStorage>)storage;
- (PMStorageCDConfiguration *)storageConfig;

- (id<PMWeatherForecastManager>)forecastManager;

@end
