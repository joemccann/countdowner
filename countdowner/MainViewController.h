//
//  MainViewController.h
//  countdowner
//
//  Created by Joe McCann on 01/14/12.
//  Copyright (c) 2012 subPrint Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController{
    UIDatePicker *datePicker;
    UILabel *label;
    UIButton *button;
    NSTimer *timer;
    BOOL hasTimerStarted;
    NSInteger totalSeconds;
}


- (NSString *)revertHoursMinutesSecondsFromTotalSecondsToString:(NSInteger)totalSeconds;

- (NSInteger)getSecondsFromHours:(NSInteger)hours andMinutes:(NSInteger)minutes andSeconds:(NSInteger)seconds;

- (void)timerUpdater;

- (void)startTimerButtonWasTapped;

@end