//
//  AppDelegate.h
//  countdowner
//
//  Created by Joe McCann on 01/14/12.
//  Copyright (c) 2012 subPrint Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *instanceOfMainViewController;

@end