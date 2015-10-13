//
//  PMServicesAssembly.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMServicesAssembly.h"
#import "PMApiClient.h"
#import "PMApiClientWWO.h"
#import <RACAFNetworking.h>
#import "PMStorageCD.h"
#import "PMStorageCDConfiguration.h"
#import "PMAppConfigurator.h"
#import "PMWeatherForecastManagerImpl.h"

@implementation PMServicesAssembly

- (id<PMApiClient>)apiClient
{
    return [TyphoonDefinition withClass:[PMApiClientWWO class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithSessionManager:apiKey:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self httpSessionManager]];
            [initializer injectParameterWith:TyphoonConfig(@"api.key")];
        }];
        definition.scope = TyphoonScopeLazySingleton;
    }];
}

- (AFHTTPSessionManager *)httpSessionManager
{
    return [TyphoonDefinition withClass:[AFHTTPSessionManager class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithBaseURL:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:TyphoonConfig(@"api.url")];
        }];
    }];
}

- (id<PMStorage>)storage
{
    return [TyphoonDefinition withClass:[PMStorageCD class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithConfig:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self storageConfig]];
        }];
    }];
}

- (PMStorageCDConfiguration *)storageConfig
{
    return [TyphoonDefinition withClass:[PMStorageCDConfiguration class] configuration:^(TyphoonDefinition *definition)
    {
        [definition injectProperty:@selector(type) with:@(PMStorageCDTypeSqlite)];
    }];
}

- (PMAppConfigurator *)appConfigurator
{
    return [TyphoonDefinition withClass:[PMAppConfigurator class] configuration:^(TyphoonDefinition *definition)
    {
        [definition injectProperty:@selector(storage)];
    }];
}

- (id<PMWeatherForecastManager>)forecastManager
{
    return [TyphoonDefinition withClass:[PMWeatherForecastManagerImpl class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithSorage:apiClient:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self storage]];
            [initializer injectParameterWith:[self apiClient]];
        }];
    }];
}

@end


