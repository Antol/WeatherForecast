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
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *query;
@end
