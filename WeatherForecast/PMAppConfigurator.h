//
//  PMAppConfigurator.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PMStorage;

@interface PMAppConfigurator : NSObject
@property (nonatomic, strong) id<PMStorage> storage;

- (BOOL)configOnStartApp;

@end
