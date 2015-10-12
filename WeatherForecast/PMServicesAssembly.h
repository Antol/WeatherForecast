//
//  PMServicesAssembly.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <Typhoon/Typhoon.h>
@protocol PMApiClient;

@interface PMServicesAssembly : TyphoonAssembly

- (id<PMApiClient>)apiClient;

@end
