//
//  AppDelegate.m
//  countdowner
//
//  Created by Joe McCann on 01/14/12.
//  Copyright (c) 2012 subPrint Interactive. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize instanceOfMainViewController = _instanceOfMainViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.instanceOfMainViewController = [[MainViewController alloc] init];
    self.window.rootViewController = self.instanceOfMainViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end