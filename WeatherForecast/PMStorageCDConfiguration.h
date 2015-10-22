//
//  PMStorageCDConfiguration.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PMStorageCDType) {
    PMStorageCDTypeSqlite,
    PMStorageCDTypeInMemory,
};

@interface PMStorageCDConfiguration : NSObject
@property (nonatomic, assign) PMStorageCDType type;
@end
