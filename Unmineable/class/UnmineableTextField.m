//
//  UnmineableTextField.m
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/18/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "UnmineableTextField.h"

@implementation UnmineableTextField
// will cause the balance and balance value fields to not display
//- (void)drawRect:(NSRect)dirtyRect {
//	NSLog(@"Drawing from textfield");
//}

- (BOOL)becomeFirstResponder {
	// inherits becomeFirstResponder from NSTextView
	BOOL responderStatus = [super becomeFirstResponder];
	
	if (responderStatus){
		NSTextView *textField = (NSTextView*)[self currentEditor];
		if([textField respondsToSelector:@selector(setInsertionPointColor:)]){
			[textField setInsertionPointColor:[NSColor blackColor]];
		}
	}
	
	NSRange selectionRange = [[self currentEditor] selectedRange];
	
	[[self currentEditor] setSelectedRange:(NSMakeRange(selectionRange.length, 0))];
	
	return responderStatus;
}
	
- (void)awakeFromNib {
	// NSLog(@"awake from textfield");
}

@end
