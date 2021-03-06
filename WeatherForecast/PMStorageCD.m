//
//  PMStorageCD.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMStorageCD.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Mantle.h"
#import "MTLManagedObjectAdapter.h"
#import "PMStorageCDConfiguration.h"

typedef NSError *(^PMPerformDataChange)(NSManagedObjectContext *localContext, MTLModel<MTLManagedObjectSerializing> *obj);

@implementation PMStorageCD

- (instancetype)initWithConfig:(PMStorageCDConfiguration *)config
{
    self = [super init];
    if (self) {
        [MagicalRecord cleanUp];
        switch (config.type) {
            case PMStorageCDTypeSqlite: [MagicalRecord setupAutoMigratingCoreDataStack]; break;
            case PMStorageCDTypeInMemory: [MagicalRecord setupCoreDataStackWithInMemoryStore]; break;
        }
    }
    return self;
}

- (RACSignal *)getAllObjectsForClass:(Class)aClass
{
    return [self getAllObjectsForClass:aClass withPredicate:nil];
}

- (RACSignal *)getAllObjectsForClass:(Class)aClass withPredicate:(NSPredicate *)predicate
{
    NSAssert([aClass conformsToProtocol:@protocol(MTLManagedObjectSerializing)],
             @"Class should conforms to protocol MTLManagedObjectSerializing");
    
    Class managedObjectClass = NSClassFromString([aClass managedObjectEntityName]);
    NSArray *savedEntities = predicate? [managedObjectClass MR_findAllWithPredicate:predicate] :
                                        [managedObjectClass MR_findAll];
    
    return [[[savedEntities.rac_sequence
        signal]
        flattenMap:^RACStream *(id x) {
            NSError *error;
            id obj = [MTLManagedObjectAdapter modelOfClass:aClass fromManagedObject:x error:&error];
            if (error) {
                return [RACSignal error:error];
            }
            else {
                return [RACSignal return:obj];
            }
        }]
        collect];
}

- (RACSignal *)saveObjects:(NSArray *)objects
{
    return [self performForEveryObject:objects
                     dataChangingBlock:^NSError *(NSManagedObjectContext *localContext, MTLModel<MTLManagedObjectSerializing> *obj)
    {
        NSError *error;
        [MTLManagedObjectAdapter managedObjectFromModel:obj insertingIntoContext:localContext error:&error];
        return error;
    }];
}

- (RACSignal *)saveSyncObjects:(NSArray *)objects
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            [objects enumerateObjectsUsingBlock:^(MTLModel<MTLManagedObjectSerializing> *obj, NSUInteger idx, BOOL *stop) {
                @strongify(self);
                NSAssert([obj isKindOfClass:[MTLModel class]] &&
                         [obj conformsToProtocol:@protocol(MTLManagedObjectSerializing)],
                         @"Object should conforms to protocol MTLManagedObjectSerializing");
                NSError *error;
                
                [MTLManagedObjectAdapter managedObjectFromModel:obj insertingIntoContext:localContext error:&error];
                
                if (error) {
                    *stop = YES;
                    [subscriber sendError:error];
                }
            }];
            
            [subscriber sendNext:@YES];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

- (RACSignal *)removeObjects:(NSArray *)objects
{
    return [self performForEveryObject:objects
                     dataChangingBlock:^NSError *(NSManagedObjectContext *localContext, MTLModel<MTLManagedObjectSerializing> *obj)
    {
        Class aClass = [obj class];
        Class managedObjectClass = NSClassFromString([aClass managedObjectEntityName]);
        NSString *uniquingKey = [[aClass propertyKeysForManagedObjectUniquing] anyObject];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@", uniquingKey, [obj valueForKey:uniquingKey]];
        NSArray *savedEntities = [managedObjectClass MR_findAllWithPredicate:pred];
        for (NSManagedObject *savedObject in savedEntities) {
            [savedObject MR_deleteEntityInContext:localContext];
        }
        return nil;
    }];
}

#pragma mark - Private

- (RACSignal *)performForEveryObject:(NSArray *)objects dataChangingBlock:(PMPerformDataChange)block
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [objects enumerateObjectsUsingBlock:^(MTLModel<MTLManagedObjectSerializing> *obj, NSUInteger idx, BOOL *stop) {
                @strongify(self);
                NSAssert([obj isKindOfClass:[MTLModel class]] &&
                         [obj conformsToProtocol:@protocol(MTLManagedObjectSerializing)],
                         @"Object should conforms to protocol MTLManagedObjectSerializing");
                
                NSError *error = block(localContext, obj);
                
                if (error) {
                    *stop = YES;
                    [subscriber sendError:error];
                }
            }];
        }
        completion:^(BOOL contextDidSave, NSError *error) {
            if (!error) {
                [subscriber sendNext:@YES];
                [subscriber sendCompleted];
            }
            else {
                [subscriber sendError:error];
            }
        }];
        return nil;
    }];
}

@end


