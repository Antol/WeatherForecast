//
//  PMStorageCDTest.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import "PMStorageCD.h"
#import "PMServicesAssembly.h"
#import "PMConfigAssembly.h"
#import <TyphoonPatcher.h>
#import "PMStorageCDConfiguration.h"
#import "PMPlace.h"
#import "LLReactiveMatchers.h"

@interface PMStorageCDTest : XCTestCase
@property (nonatomic, strong) PMStorageCD *storage;
@end

@implementation PMStorageCDTest

- (void)setUp
{
    [super setUp];
    PMServicesAssembly *assembly = [[PMServicesAssembly assembly]
                                    activateWithCollaboratingAssemblies:@[[PMConfigAssembly assembly]]];
    
    TyphoonPatcher *patcher = [[TyphoonPatcher alloc] init];
    [patcher patchDefinitionWithSelector:@selector(storageConfig) withObject:^id{
        PMStorageCDConfiguration *config = [PMStorageCDConfiguration new];
        config.type = PMStorageCDTypeInMemory;
        return config;
    }];
    [assembly attachPostProcessor:patcher];
    
    self.storage = [assembly storage];
}

- (void)tearDown
{
    self.storage = nil;
    [super tearDown];
}

- (void)testStorageExists
{
    expect(self.storage).toNot.beNil();
}

- (void)testSavePlace
{
    PMPlace *place = [PMPlace new];
    place.name = @"Hogwarts";
    place.region = @"Old England";
    place.country = @"England";
    place.query = @"Hogwarts,England";
    place.latitude = @42;
    place.longitude = @42;
    
    RACSignal *savedEntitiesSignal = [[self.storage
        saveObjects:@[place]]
        then:^RACSignal *{
            return [self.storage getAllObjectsForClass:[PMPlace class]];
        }];
    
    expect(savedEntitiesSignal).will.sendValues(@[@[place]]);
}

- (void)testRemovePlace
{
    PMPlace *place = [PMPlace new];
    place.name = @"Hogwarts";
    place.region = @"Old England";
    place.country = @"England";
    place.query = @"Hogwarts,England";
    place.latitude = @42;
    place.longitude = @42;
    
    RACSignal *savedEntitiesSignal = [[[self.storage
        saveObjects:@[place]]
        then:^RACSignal *{
            return [self.storage removeObjects:@[place]];
        }]
        then:^RACSignal *{
            return [self.storage getAllObjectsForClass:[PMPlace class]];
        }];
    
    expect(savedEntitiesSignal).will.sendValues(@[@[]]);
}

@end


