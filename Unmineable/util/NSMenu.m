//
//  NSMenu+NSMenu.m
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/30/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "NSMenu.h"
#import <AppKit/AppKit.h>


@implementation NSMenu (HighlightItemsUsingPrivateAPIs)

- (void)_highlightItem:(NSStatusItem *)menuItem {
	// method selector
	// const SEL selHighlightItem = @selector(_highlightItem:); // fails
	const SEL selHighlightItem = @selector(highlightItem:);
	if ([self respondsToSelector:selHighlightItem]){
		[self performSelector:selHighlightItem withObject:menuItem];
	}
}

@end
