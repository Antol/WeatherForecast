//
//  PMCitiesListVC.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 11.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PMWeatherForecastManager;

@interface PMPlacesListVC : UIViewController
@property (nonatomic, strong) id<PMWeatherForecastManager> forecastManager;
@end
