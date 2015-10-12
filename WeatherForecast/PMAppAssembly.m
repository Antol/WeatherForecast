//
//  PMAppAssembly.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 11.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMAppAssembly.h"
#import "PMAppDelegate.h"
#import "PMCitiesListVC.h"

@implementation PMAppAssembly

- (PMAppDelegate *)appDelegate
{
    return [TyphoonDefinition withClass:[PMAppDelegate class]];
}

- (PMCitiesListVC *)PMCitiesListVC
{
    return [TyphoonDefinition withClass:[PMCitiesListVC class] configuration:^(TyphoonDefinition *definition)
    {
        [definition injectProperty:@selector(test)];
    }];
}

@end
