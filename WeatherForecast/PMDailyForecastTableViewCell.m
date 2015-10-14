//
//  PMDailyForecastTableViewCell.m
//  WeatherForecast
//
//  Created by Antol Peshkov on 14.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//

#import "PMDailyForecastTableViewCell.h"
#import "PMCondition.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface PMDailyForecastTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *temperatureMinMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescription;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@end

@implementation PMDailyForecastTableViewCell

- (void)awakeFromNib
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"EEE";
    });
    
    @weakify(self);
    [RACObserve(self, condition) subscribeNext:^(PMCondition *condition) {
        @strongify(self);
        self.temperatureMinMaxLabel.text = [NSString stringWithFormat:@"%@° / %@°", condition.temperatureMaxC, condition.temperatureMinC];
        self.weatherDescription.text = condition.weatherDescription;
        self.dateLabel.text = [dateFormatter stringFromDate:condition.date];
        [self.weatherImageView setImageWithURL:condition.weatherIconUrl];
    }];
}

@end
