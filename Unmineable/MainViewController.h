//
//  MainViewController.h
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/14/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Util.h"
#import "UnmineableTextField.h"
#import "UnmineableTextFieldCell.h"
#import "util/Util.Color/UtilColor.h"
#import "util/NetworkRequest.h"


NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : NSViewController


@property (weak, nonatomic) IBOutlet NSView *mainView;
@property (weak, nonatomic) IBOutlet NSTextField *unLabel;
@property (weak, nonatomic) IBOutlet NSTextField *mineableLabel;
@property (weak, nonatomic) IBOutlet NSButton *searchButton;
@property (weak, nonatomic) IBOutlet UnmineableTextField *addressField; // custom field
@property (weak, nonatomic) IBOutlet UnmineableTextFieldCell *textFieldCell; // custom cell

// displaying current balance
@property (weak, nonatomic) IBOutlet UnmineableTextField *balanceLabel;
@property (weak, nonatomic) IBOutlet UnmineableTextFieldCell *balanceLabelCell;

// displaying calculated market balance
@property (weak, nonatomic) IBOutlet UnmineableTextField *balanceValueLabel;
@property (weak, nonatomic) IBOutlet UnmineableTextFieldCell *balanceValueLabelCell;

// actions
- (IBAction)callAPI:(id)sender;

- (void)unmineableAPIRequest;
- (void)bitfinexAPIRequest:(NSString *)baseURI endpoint:(NSString *)endpoint tickerParameter:(NSString *)coinTickerType unmineableBalance:(CGFloat)balance;

// leaving this out so that it can be a private function - (void)loadLastAddress;
+ (void)refreshData;
@end

NS_ASSUME_NONNULL_END
