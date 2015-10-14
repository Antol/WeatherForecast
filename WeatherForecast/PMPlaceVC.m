//
//  PMPlaceVC.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMPlaceVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PMWeatherForecast.h"
#import "PMPlace.h"

@interface PMPlaceVC ()

@end

@implementation PMPlaceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    @weakify(self);
    [RACObserve(self, forecast) subscribeNext:^(PMWeatherForecast *forecast) {
        @strongify(self);
        self.title = forecast.place.name;
    }];
}

@end
