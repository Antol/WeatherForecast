//
//  PMPlace.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMBaseModel.h"
@class PMCondition;

@interface PMPlace : PMBaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *query;
@property (nonatomic, strong) PMCondition *currentCondition;
@property (nonatomic, strong) NSArray *dailyForecastConditions;
@end
