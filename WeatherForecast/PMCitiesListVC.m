//
//  PMCitiesListVC.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 11.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMCitiesListVC.h"
#import "PMApiClient.h"
#import "PMStorage.h"
#import "PMPlace.h"

@interface PMCitiesListVC ()

@end

@implementation PMCitiesListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self.storage getAllObjectsForClass:[PMPlace class]] subscribeNext:^(id x) {
        NSLog(@"================> %@", x);
    }];
}

@end
