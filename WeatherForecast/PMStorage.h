//
//  PMStorage.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol PMStorage <NSObject>
- (RACSignal *)getAllObjectsForClass:(Class)aClass;
- (RACSignal *)getAllObjectsForClass:(Class)aClass withPredicate:(NSPredicate *)predicate;
- (RACSignal *)saveObjects:(NSArray *)objects;
- (RACSignal *)saveSyncObjects:(NSArray *)objects;
@end
