//
//  UnmineableMainView.m
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/28/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "UnmineableMainView.h"


@implementation UnmineableMainView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

// this hides the placeholder and any text inputted
//- (void)mouseDown:(NSEvent *)event {
////	AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
//	[self.window makeFirstResponder:NULL];
//}

// triggers when clicked outside textfield
- (void)mouseDown:(NSEvent *)event {
	// reset cursor to front, without removing input, and without highlighting
	[self.addressTextField currentEditor].selectedRange = NSMakeRange(0, 0);
	[self.addressTextField selectText:[self.addressTextField.stringValue substringFromIndex:0]];
	[self.addressTextField selectWithFrame:self.addressTextField.bounds editor:[self.addressTextField currentEditor] delegate:NULL start:0 length:0];
	
	//	double timeDelaySeconds = 0.5;
	//	dispatch_time_t dispatchedTimer = dispatch_time(DISPATCH_TIME_NOW, timeDelaySeconds * NSEC_PER_SEC);
	//	dispatch_after(dispatchedTimer, dispatch_get_main_queue(), ^(void){
	//		// use this timer for something else :p
	//	});
}

@end
