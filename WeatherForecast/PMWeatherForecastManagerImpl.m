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
@property (nonatomic, assign) BOOL isActivated;
@end

@implementation PMWeatherForecastManagerImpl

@synthesize forecasts;

- (instancetype)initWithSorage:(id<PMStorage>)storage apiClient:(id<PMApiClient>)apiClient
{
    self = [super init];
    if (self) {
        self.storage = storage;
        self.apiClient = apiClient;
    }
    return self;
}

- (void)activate
{
    if (self.isActivated) {
        return;
    }
    self.isActivated = YES;
    
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
    NSUInteger index = [self.places indexOfObjectPassingTest:^BOOL(PMPlace *savedPlace, NSUInteger idx, BOOL * _Nonnull stop) {
        return [savedPlace.query isEqualToString:place.query];
    }];
    
    if (index != NSNotFound) {
        NSString *errorDesc = [NSString stringWithFormat:@"%@ already added", place.name];
        RACSignal *errorSignal = [RACSignal error:[NSError errorWithDomain:errorDesc
                                                                      code:0
                                                                  userInfo:nil]];
        return errorSignal;
    }
    
    NSMutableArray *mutablePlaces = [self.places mutableCopy];
    [mutablePlaces addObject:place];
    self.places = [mutablePlaces copy];
    
    return [self.storage saveObjects:@[place]];
}

- (RACSignal *)removePlace:(PMPlace *)place
{
    NSMutableArray *mutablePlaces = [self.places mutableCopy];
    [mutablePlaces removeObject:place];
    self.places = [mutablePlaces copy];
    
    return [self.storage removeObjects:@[place]];
}

@end


