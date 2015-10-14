//
//  PMSearchVC.h
//  WeatherForecast
//
//  Created by Antol Peshkov on 13.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PMApiClient;

@interface PMSearchVC : UITableViewController
@property (nonatomic, strong) id<PMApiClient> apiClient;
@end
