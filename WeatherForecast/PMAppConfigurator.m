//
//  PMAppConfigurator.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMAppConfigurator.h"
#import "PMStorage.h"
#import "PMPlace.h"

static NSString *const kPMAppConfiguratorApreadyStarted = @"kPMAppConfiguratorApreadyStarted";

@implementation PMAppConfigurator

- (BOOL)configOnStartApp
{
    BOOL success = YES;
    
    if ([self isFirstStart]) {
        [self saveFirstStart];
        
        PMPlace *defaultPlace = [PMPlace new];
        defaultPlace.name = @"Dublin";
        defaultPlace.region = @"Dublin";
        defaultPlace.country = @"Ireland";
        defaultPlace.latitude = @53.333;
        defaultPlace.longitude = @(-6.249);
        defaultPlace.query = @"Dublin, Dublin, Ireland";
        
        NSError *error = nil;
        success = [[self.storage saveSyncObjects:@[defaultPlace]] waitUntilCompleted:&error];
        
        if (error) {
            NSLog(@"================> %@", error);
        }
    }
    return success;
}

#pragma mark - Private

- (BOOL)isFirstStart
{
    BOOL isFirstStart = ![[NSUserDefaults standardUserDefaults] boolForKey:kPMAppConfiguratorApreadyStarted];
    return isFirstStart;
}

- (void)saveFirstStart
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kPMAppConfiguratorApreadyStarted];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end


