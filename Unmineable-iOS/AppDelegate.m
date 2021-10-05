//
//  AppDelegate.m
//  Unmineable-iOS
//
//  Created by Gabriel Betancourt on 9/17/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
	NSLog(@"Will finish launching");
	return TRUE;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	NSLog(@"Will didFinishLaunching");
	return YES;
}

@end
