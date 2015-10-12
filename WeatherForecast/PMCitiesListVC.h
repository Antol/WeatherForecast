//
//  PMCitiesListVC.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 11.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PMApiClient;

@interface PMCitiesListVC : UIViewController
@property (nonatomic, assign) id<PMApiClient> test;
@end
