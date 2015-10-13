//
//  PMWeatherForecastManager.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@class PMPlace;

@protocol PMWeatherForecastManager <NSObject>
@property (nonatomic, strong) NSArray *forecasts;
- (RACSignal *)updateAll;
- (RACSignal *)addPlace:(PMPlace *)place;
@end
