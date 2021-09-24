//
//  InterfaceController.m
//  Unmineable-Watch Extension
//
//  Created by Gabriel Betancourt on 9/18/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController ()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
	NSLog(@"Apple watch app visible.");
	// entry point
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



