//
//  NSMenu+NSMenu.h
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/30/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//


#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSMenu (HighlightItemsUsingPrivateAPIs)

- (void)_highlightItem:(NSStatusItem *)menuItem;

@end

NS_ASSUME_NONNULL_END
