//
//  AppDelegate.m
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/13/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "AppDelegate.h"
#import <Cocoa/Cocoa.h>
#import "NSMenu.h"
#import "MainViewController.h"


static NSString *balanceStr = @"";
static NSString *marketValueStr = @"";
static int previousMenuSelection;
static id static_self = NULL;
// static BOOL dataEmpty = TRUE; use this to refresh data on start

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	//	NSArray *runningApps = [[NSWorkspace sharedWorkspace] runningApplications];
	//	AXUIElementCopyAttributeValues(<#AXUIElementRef  _Nonnull element#>, <#CFStringRef  _Nonnull attribute#>, <#CFIndex index#>, <#CFIndex maxValues#>, <#CFArrayRef  _Nullable * _Nonnull values#>)
	//	NSLog(@"Running applications: %@", runningApps);
	
	//	NSNotificationCenter *notCenter;
	//	// Assume -observerMethod:(id)aNotification exists
	//	notCenter = [[NSWorkspace sharedWorkspace] notificationCenter];
	//	[notCenter addObserver:self
	//						 selector:@selector(notificationObserverMethod:)
	//						 name:nil object:nil]; // Register for all notifications
	
	
	// Insert code here to initialize your application
	//	NSMutableAttributedString *unAttributedStr = [[NSMutableAttributedString alloc] initWithString:_unChar];
	//	NSMutableAttributedString *mineableAttributedStr = [[NSMutableAttributedString alloc] initWithString:_mineableChar];
		
	//	[unAttributedStr addAttribute:[NSFont font] value:<#(nonnull id)#> range:<#(NSRange)#>]
	//	[unAttributedStr addAttribute:[NSFont fontWithName:<#(nonnull NSString *)#> size:<#(CGFloat)#>] value:<#(nonnull id)#> range:<#(NSRange)#>]
		
	//	[unAttributedStr addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"poppins" size:10.0f] range:NSMakeRange(0, unAttributedStr.length)];
	//	[mineableAttributedStr addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"Fredoka One" size:10.0f] range:NSMakeRange(0, mineableAttributedStr.length)];
	static_self = self;
	NSStatusBar *statusBar = NSStatusBar.systemStatusBar;
	NSStatusItem *statusBarItem = [statusBar statusItemWithLength:120.0f];
	
	NSMenu *statusBarMenu = [[NSMenu alloc] initWithTitle:@"unMineableStatusBarMenu"];
	statusBarItem.menu = statusBarMenu;
	// statusBarItem.button.title = [NSString stringWithFormat:@"%@%@", unAttributedStr.string, mineableAttributedStr.string];
	
	self.retainedStatusItem = statusBarItem;
	
	// statusBarItem.button.title = @"uM: 0.02144008 ETH | $71.41"; // format this string with calculated values
	statusBarItem.button.title = @"unMineable";
	
	[statusBarMenu addItemWithTitle:@"None" action:@selector(menuSelectionAction:) keyEquivalent:@"none"];
	[statusBarMenu addItemWithTitle:@"Show balance" action:@selector(menuSelectionAction:) keyEquivalent:@"show_balance"];
	[statusBarMenu addItemWithTitle:@"Show market value" action:@selector(menuSelectionAction:) keyEquivalent:@"show_market_value"];
	[statusBarMenu addItemWithTitle:@"Show balance + market value" action:@selector(menuSelectionAction:) keyEquivalent:@"show_balance_and_market_value"];
	
	[statusBarMenu addItem:[NSMenuItem separatorItem]];
	
	NSMenuItem *refreshDataItem = [[NSMenuItem alloc] initWithTitle:@"Refresh" action:@selector(menuSelectionAction:) keyEquivalent:@"refresh_data"];
	// in order for this item to not be blank, it needs context to the responder chain (in this case appdelegate)
	// and therefore needs an action method that is attached to the context (instance) of appdelegate class
	// this is why setTarget:self starts working and Refresh menu item is not blank
	//[refreshDataItem setTarget:self]; // don't needs this if action is specified for menu item as I have found out
	[statusBarMenu addItem:refreshDataItem];
	

	NSArray *keyShortcuts = @[@"N", @"B", @"M", @"V", @"R"];
	//	for (uint32 i = 0; i < statusBarMenu.itemArray.count; i++){
	//		if ( i == 4 ){
	//			continue;
	//		}
	//
	//		[[statusBarMenu itemAtIndex:i] setTag:i];
	//		NSLog(@"Menu item: %@", [statusBarMenu itemAtIndex:i]);
	//		[[statusBarMenu itemAtIndex:i] setKeyEquivalent:keyShortcuts[i]];
	//	}
	
	for (uint32 i = 0; i < keyShortcuts.count; i++ ){
		if ( i == 4 ){
			[[statusBarMenu itemAtIndex:5] setTag:i];
			[[statusBarMenu itemAtIndex:5] setKeyEquivalent:keyShortcuts[i]];
		} else {
			[[statusBarMenu itemAtIndex:i] setTag:i];
			[[statusBarMenu itemAtIndex:i] setKeyEquivalent:keyShortcuts[i]];
		}
	}
	
	self.retainedMenu = statusBarMenu;
	
	// set default selected option
	[[self.retainedMenu itemAtIndex:0] setState:NSControlStateValueOn];
	menuItemWithSelectedState = 0;
	
	// need to figure out how to make the key shortcuts work when menu is not visible
	// when application is running and user has not clicked the menu bar, but the context is on Unmineable app
	// NOTE: Getting the shortcuts to work from the window shoud be pushed to another time and should actually be done from the file menu for the app instead
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
	NSLog(@"Teminating application: %@", aNotification);
}

- (void)menuSelectionAction:(id)sender {
	NSMenuItem *menuItem = (NSMenuItem*)sender;
	
	// use tag index from menuItem, match it with enum index, then print out the value selected from the enum bassed on string
	enum menuOptions selectedOption;
	selectedOption = (int)menuItem.tag; // sets 5 item from the enum (4th index) if refresh_data is selected (for example)
	
	
	
	// NSLog(@"Previous selected menu item: %i", menuItemWithSelectedState);
	if ( selectedOption != menuItemWithSelectedState ){
		[[self.retainedMenu itemAtIndex:menuItemWithSelectedState] setState:NSControlStateValueOff];
	}

	NSLog(@"Mapped value: %@", menuOptionString(selectedOption));
	// NSLog(@"Menu item key: %@", ([menuItem keyEquivalent]));

	[[self.retainedMenu itemAtIndex:selectedOption] setState:NSControlStateValueOn];
	
	[self refreshMenuDataAfterMenuSelection:selectedOption dataExecutionBlock:^{
		self.retainedStatusItem.button.title = [NSString stringWithFormat:@"Refreshing data........"];
		self.retainedStatusItem.length = 250.0f;
		previousMenuSelection = self->menuItemWithSelectedState;
		[MainViewController refreshData];
	}];
	
	if (selectedOption == refresh_data){
		[[self.retainedMenu itemAtIndex:menuItemWithSelectedState] setState:NSControlStateValueOn];
	} else {
		menuItemWithSelectedState = selectedOption;
	}
}

- (void)refreshMenuDataAfterMenuSelection:(enum menuOptions)menuSelection dataExecutionBlock:(void (^)(void))executionBlock {
	switch (menuSelection) {
		case none:
			self.retainedStatusItem.button.title = @"Unmineable";
			self.retainedStatusItem.length = 120.0f;
			break;
		case show_balance:
			// mutate the status bar string
			self.retainedStatusItem.button.title = balanceStr;
			self.retainedStatusItem.length = 120.0f;
			break;
		case show_market_value:
			self.retainedStatusItem.button.title = [NSString stringWithFormat:@"$%.2f", [marketValueStr doubleValue]];
			self.retainedStatusItem.length = 120.0f;
			break;
		case show_balance_and_market_value:
			self.retainedStatusItem.button.title = [NSString stringWithFormat:@"%@ ETH | $%.2f", balanceStr, [marketValueStr doubleValue]];
			self.retainedStatusItem.length = 250.0f;
			break;
		case refresh_data:
			executionBlock();
			break;
		default:
			NSLog(@"selectedOption default switch item. Nothing to do.");
			break;
	}
}

+ (void)getApiCallFromMainBalance:(CGFloat)balance withMarketValue:(CGFloat)marketValue {
	balanceStr = [NSString stringWithFormat:@"%.8f", balance];
	marketValueStr = [NSString stringWithFormat:@"%.8f", marketValue];
	[static_self refreshMenuDataAfterMenuSelection:previousMenuSelection dataExecutionBlock:NULL];
}

- (void)refreshData { // dont need this
	NSLog(@"Refreshing data...");
}

//- (void)computeWithBlockAsync:(void (^)(void))callBlock callOnReturn:(void (^)(void))returnBlock {
//	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//	
//	dispatch_async(queue, ^{
//		callBlock();
//		
//		dispatch_async(dispatch_get_main_queue(), ^{
//			returnBlock();
//		});
//	});
//	
////	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
////		block();
////	});
//}

//- (void)notificationObserverMethod:(id)sender {
//	//NSLog(@"\n\n\n\n\n\n notification observer sender: %@\n\n\n\n\n\n\n", sender);
//	// sender first responds with the notification about the app you switched to + the app you came from
//
//}

@end
