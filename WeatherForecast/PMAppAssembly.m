//
//  PMAppAssembly.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 11.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMAppAssembly.h"
#import "PMAppDelegate.h"
#import "PMPlacesListVC.h"

@implementation PMAppAssembly

- (PMAppDelegate *)appDelegate
{
    return [TyphoonDefinition withClass:[PMAppDelegate class] configuration:^(TyphoonDefinition *definition)
    {
        [definition injectProperty:@selector(configurator)];
    }];
}

- (PMPlacesListVC *)PMCitiesListVC
{
    return [TyphoonDefinition withClass:[PMPlacesListVC class] configuration:^(TyphoonDefinition *definition)
    {
        [definition injectProperty:@selector(apiClient)];
        [definition injectProperty:@selector(storage)];
    }];
}

@end
