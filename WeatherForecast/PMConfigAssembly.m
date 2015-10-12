//
//  PMConfigAssembly.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMConfigAssembly.h"

@implementation PMConfigAssembly

- (id)config
{
    return [TyphoonDefinition configDefinitionWithName:@"Configuration.plist"];
}

@end
