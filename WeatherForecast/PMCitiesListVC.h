//
//  PMCitiesListVC.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 11.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PMApiClient;
@protocol PMStorage;

@interface PMCitiesListVC : UIViewController
@property (nonatomic, assign) id<PMApiClient> apiClient;
@property (nonatomic, strong) id<PMStorage> storage;
@end
