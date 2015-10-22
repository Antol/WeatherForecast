//
//  PMDailyForecastTableViewCell.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 14.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PMCondition;

@interface PMDailyForecastTableViewCell : UITableViewCell
@property (nonatomic, strong) PMCondition *condition;
@end
