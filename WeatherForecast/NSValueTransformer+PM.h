//
//  NSValueTransformer+PM.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValueTransformer (PM)

+ (instancetype)PM_dateAndTimeTransformer;
+ (instancetype)PM_stringToNumberTransformer;

@end
