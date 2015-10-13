//
//  PMWeatherForecastManagerImpl.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMWeatherForecastManagerImpl.h"
#import "PMStorage.h"
#import "PMPlace.h"
#import "PMApiClient.h"

@interface PMWeatherForecastManagerImpl ()
@property (nonatomic, assign) id<PMApiClient> apiClient;
@property (nonatomic, strong) id<PMStorage> storage;

@property (nonatomic, strong) NSArray *places;
@end

@implementation PMWeatherForecastManagerImpl

@synthesize forecasts;

- (instancetype)initWithSorage:(id<PMStorage>)storage apiClient:(id<PMApiClient>)apiClient
{
    self = [super init];
    if (self) {
        self.storage = storage;
        self.apiClient = apiClient;
        
        @weakify(self);
        [[self.storage getAllObjectsForClass:[PMPlace class]] subscribeNext:^(id x) {
            @strongify(self);
            self.places = x;
        }];
        
        RAC(self, forecasts) = [RACObserve(self, places) flattenMap:^RACStream *(id value) {
            @strongify(self);
            return [self updateAll];
        }];
    }
    return self;
}

- (RACSignal *)updateAll
{
    @weakify(self);
    return [[[self.places.rac_sequence
        signal]
        flattenMap:^RACStream *(PMPlace *place) {
            @strongify(self);
            return [self.apiClient getWeatherForecastForPlace:place];
        }]
        collect];
}

- (RACSignal *)addPlace:(PMPlace *)place
{
    return [RACSignal error:[NSError errorWithDomain:@"TODO" code:0 userInfo:nil]];
}

@end


