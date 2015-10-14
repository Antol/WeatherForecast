//
//  PMApiClientWWO.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMApiClientWWO.h"
#import <RACAFNetworking.h>
#import "PMPlace.h"
#import "PMWeatherForecast.h"
#import "PMWeatherForecastWWO.h"
#import "PMPlaceWWO.h"

@interface PMApiClientWWO ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSString *apiKey;
@end

@implementation PMApiClientWWO

- (instancetype)initWithSessionManager:(AFHTTPSessionManager *)sessionManager apiKey:(NSString *)apiKey
{
    self = [super init];
    if (self) {
        self.sessionManager = sessionManager;
        self.apiKey = apiKey;
    }
    return self;
}

- (RACSignal *)searchPlaceByName:(NSString *)name
{
    NSMutableDictionary *params = [[self baseParameters] mutableCopy];
    [params setValue:name forKey:@"q"];
    
    RACSignal *request = [[self.sessionManager
        rac_GET:@"search.ashx" parameters:params]
        flattenMap:^RACStream *(RACTuple *x) {
            NSDictionary *response = x.first;
            id data = [response valueForKeyPath:@"search_api.result"];
            if (data) {
                return [RACSignal return:data];
            }
            
            id errorMsg = [[[response valueForKeyPath:@"data.error"] firstObject] valueForKey:@"msg"];
            NSError *error = [NSError errorWithDomain:errorMsg?:@"Unknown error" code:0 userInfo:nil];
            return [RACSignal error:error];
        }];
    return [self mappedResponseRequestWithRequest:request responseClass:[PMPlaceWWO class]];
}

- (RACSignal *)getWeatherForecastForPlace:(PMPlace *)place
{
    NSMutableDictionary *params = [[self baseParameters] mutableCopy];
    [params setValue:place.query forKey:@"q"];
    [params setValue:@5 forKey:@"num_of_days"];
    
    RACSignal *request = [[self.sessionManager
        rac_GET:@"weather.ashx" parameters:params]
        map:^id(RACTuple *x) {
            return x.first;
        }];
    
    return [[self
        mappedResponseRequestWithRequest:request responseClass:[PMWeatherForecastWWO class]]
        map:^id(PMWeatherForecast *forecast) {
            forecast.place = place;
            return forecast;
        }];
}

#pragma mark - Private

- (NSDictionary *)baseParameters
{
    return @{
        @"key": self.apiKey,
        @"format": @"json"
    };
}

#pragma mark - Mapping

- (RACSignal *)mappedResponseRequestWithRequest:(RACSignal *)request responseClass:(Class)responseClass
{
    @weakify(self);
    return [[[request
        deliverOn:[RACScheduler scheduler]]
        flattenMap:^RACStream *(NSDictionary *response) {
            @strongify(self);
            NSError *error = nil;
            id object = [self mapResponse:response toClass:responseClass error:&error];
            if (error) {
                return [RACSignal error:error];
            }
            else {
                return [RACSignal return:object];
            }
        }]
        deliverOn:[RACScheduler mainThreadScheduler]];
}

- (id)mapResponse:(id)response toClass:(Class)responseClass error:(NSError *__autoreleasing *)error
{
    if (!response || !responseClass) {
        return response;
    }
    else if ([response isKindOfClass:[NSArray class]]) {
        return [MTLJSONAdapter modelsOfClass:responseClass fromJSONArray:response error:error];
    }
    else {
        return [MTLJSONAdapter modelOfClass:responseClass fromJSONDictionary:response error:error];
    }
}

@end


