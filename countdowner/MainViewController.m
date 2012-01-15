//
//  MainViewController.m
//  countdowner
//
//  Created by Joe McCann on 01/14/12.
//  Copyright (c) 2012 subPrint Interactive. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"View did load");

    // Set the root view's background color
    self.view.backgroundColor = [UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:0.8f];

    //Create our label (text)
   	label = [[UILabel alloc] init];
   	label.frame = CGRectMake(10, 10, 300, 40);
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"Create your Countdown Timer.";

    // Add the label to the view
   	[self.view addSubview:label];

    // Create our button
    button =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 70, 300, 40);

    // The title color
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    // Set title text
    [button setTitle:@"Start Timer" forState:UIControlStateNormal];

    // Now wire up the button to the "wasTapped" handler.
    [button addTarget:self action:@selector(startTimerButtonWasTapped) forControlEvents:UIControlEventTouchUpInside];

    // Add it to the view
    [self.view addSubview:button];
    

    // Initialize the datepicker
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 250)];   // These values set the x,y and width, height
	datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
	datePicker.hidden = NO;

	// Attach an instance of NSDate to the date property of datePicker
    datePicker.date = [NSDate date];

	// Now add the datePicker to the root view
    [self.view addSubview:datePicker];


}


// Return a string to be used representing hours, minutes, seconds (used in updating the label text).
- (NSString *)revertHoursMinutesSecondsFromTotalSecondsToString:(NSInteger)totalNumberOfSeconds {

    NSInteger hours = 0;
    NSInteger minutes = 0;
    NSUInteger numberOfSecondsInOneHour = 3600;
    NSUInteger numberOfSecondsInOneMinute = 60;

    // Example case: totalSeconds = 12305
    if(totalNumberOfSeconds > numberOfSecondsInOneHour ){
        // Then we have at least an hour
        // in the example case we have 3 from 12305/3600
        hours = (NSInteger)(floor(totalNumberOfSeconds/3600));

        // We need to update totalSeconds to reflect it minus the number of hours
        // in the example case 12305 - 10800 = 1505
        totalNumberOfSeconds = totalNumberOfSeconds - (hours*3600);

    }
    
    if(totalNumberOfSeconds > numberOfSecondsInOneMinute){
      // then we have at least one hour
        minutes = (NSInteger)floor(totalNumberOfSeconds/60); // in the example case we have 25 from 1505/60
        // update total seconds again.
        totalNumberOfSeconds = totalNumberOfSeconds - (minutes*60);
    }

    // Read this for string formatting specifiers:
    // http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
    NSString *timeToString = [NSString stringWithFormat:@"%ld:%ld:%ld", hours, minutes, totalNumberOfSeconds];

    return timeToString;

}

// Just a helper method to return the total number of seconds from hours, minutes, seconds as a string
- (NSInteger)getSecondsFromHours:(NSInteger)hours andMinutes:(NSInteger)minutes andSeconds:(NSInteger)seconds{

    // We want to return the total number of seconds
    NSUInteger numberOfSecondsInOneHour = 3600;
    NSUInteger numberOfSecondsInOneMinute = 60;

    NSInteger hourSeconds = hours * numberOfSecondsInOneHour;
    
    NSInteger minuteSeconds = minutes * numberOfSecondsInOneMinute;

    // Add them all up
    NSInteger allSeconds = hourSeconds + minuteSeconds + seconds;
    
    return allSeconds;
    
}

// This is the method that is run when the timer is initialized.
// It is run every time based on the timer interval (in our case, every second)
- (void)timerUpdater{

    // First, get the current timestamp
    if(!hasTimerStarted){

        // Create a calender for the NSDateComponents below
        NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;

        // Grab the date components from the datepicker
        NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:datePicker.date];

        // Grab the hours and minutes
        NSInteger hours = [dateComponents hour];
        NSInteger minutes = [dateComponents minute];

        NSLog(@"Hours: %d", hours);
        NSLog(@"Minutes: %d", minutes);

        // We need the countdown converted to seconds
        totalSeconds = [self getSecondsFromHours:hours andMinutes:minutes andSeconds:0];

        // We need to set this flag to true (YES) so we don't do the above code again
        hasTimerStarted = YES;
    }
    else{

       // Decrement the total number of seconds
       totalSeconds--;

       // Update the UI
       label.text = [self revertHoursMinutesSecondsFromTotalSecondsToString:totalSeconds];
    }

    NSLog(@"Total Seconds: %d", totalSeconds);

    // If totalSeconds has equaled zero, then timer is up!
    if (totalSeconds == 0){

        // Show an alert because the time is up.
        UIAlertView *alert = [[UIAlertView alloc]
                initWithTitle:@"Time's UP"
                      message:@"Your countdown is complete!"
                     delegate:self
            cancelButtonTitle:nil otherButtonTitles:@"OK!", nil];

        // Setting this to -1 will not show the cancel button.
        alert.cancelButtonIndex = -1;

        // Now show the alert!
        [alert show];

        // Reset the timer
        [timer invalidate];

        // Update the flag so we can create another timer if we want
        hasTimerStarted = NO;
    }

    
}

// Button tap event handler
- (void)startTimerButtonWasTapped {

    NSLog(@"Button clicked!");

    // Create timer instance
    if (timer != nil){
        // Here we are resetting it so as to start another timer on each click of the button.
        [timer invalidate];
        hasTimerStarted = NO;
    }

    // Now initialize the timer.
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(timerUpdater)
                                           userInfo:nil repeats:YES];


}


@end