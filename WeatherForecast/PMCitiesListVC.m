//
//  PMCitiesListVC.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 11.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMCitiesListVC.h"
#import "PMApiClient.h"

@interface PMCitiesListVC ()

@end

@implementation PMCitiesListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"================> %@", self.test);
    [[self.test searchPlaceByName:@"temp"] subscribeNext:^(id x) {
        NSLog(@"================> %@", x);
    } error:^(NSError *error) {
        NSLog(@"================> %@", error);
    }];
}

@end
