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

@end
