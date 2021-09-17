//
//  AppDelegate.h
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/13/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import <Cocoa/Cocoa.h>

enum menuOptions {
	none = 0,
	show_balance = 1,
	show_market_value = 2,
	show_balance_and_market_value = 3,
	refresh_data = 4
};

// macro to map menu option keyequivalent to enum indexes
// NOTE if more options are added to the enum menu, same option has to be added here to map properly
#define menuOptionString(enum)[@[@"none",@"show_balance", @"show_market_value", @"show_balance_and_market_value", @"refresh_data"] objectAtIndex:enum]

@interface AppDelegate : NSObject <NSApplicationDelegate> {
	int menuItemWithSelectedState;
	/* Key Shortcuts for menu items
	 CMD + SHIFT + N = None
	 CMD + SHIFT B = show balance
	 CMD + SHIFT M = show market value
	 CMD + SHIFT V = show balance and market value
	 CMD + SHIFT R = refresh data
	 */
}

@property (retain) NSStatusItem *retainedStatusItem;
@property (retain) NSMenu *retainedMenu;
@property (weak, nonatomic) NSString *unChar;
@property (weak, nonatomic) NSString *mineableChar;
@property (retain, nonatomic) NSMutableDictionary *balanceInfo;

- (void)refreshMenuDataAfterMenuSelection:(enum menuOptions)menuSelection dataExecutionBlock:(void (^)(void))executionBlock;
+ (void)getApiCallFromMainBalance:(CGFloat)balance withMarketValue:(CGFloat)marketValue;
- (void)refreshData;

//- (void)computeWithBlockAsync:(void (^)(void))block;
@end

