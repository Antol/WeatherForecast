//
//  PMStorageCD.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMStorage.h"
@class PMStorageCDConfiguration;

@interface PMStorageCD : NSObject <PMStorage>

- (instancetype)initWithConfig:(PMStorageCDConfiguration *)config;

@end
