//
//  PMApiClientWWO.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMApiClient.h"

@interface PMApiClientWWO : NSObject <PMApiClient>

- (instancetype)initWithBaseURL:(NSURL *)baseUrl;

@end
