//
//  PMPlaceVC.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PMWeatherForecast;

@interface PMPlaceVC : UIViewController
@property (nonatomic, strong) PMWeatherForecast *forecast;
@end
