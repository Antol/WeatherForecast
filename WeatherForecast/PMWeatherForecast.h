//
//  PMWeatherForecast.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMBaseModel.h"
@class PMCondition;
@class PMPlace;

@interface PMWeatherForecast : PMBaseModel
@property (nonatomic, strong) PMPlace *place;
@property (nonatomic, strong) PMCondition *currentCondition;
@property (nonatomic, strong) NSArray *dailyForecastConditions;
@end
