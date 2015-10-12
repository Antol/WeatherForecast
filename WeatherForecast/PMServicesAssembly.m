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

@implementation PMServicesAssembly

- (id<PMApiClient>)apiClient
{
    return [TyphoonDefinition withClass:[PMApiClientWWO class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithBaseURL:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:TyphoonConfig(@"api.url")];
        }];
        definition.scope = TyphoonScopeLazySingleton;
    }];
}

@end
