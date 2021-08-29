//
//  MainViewController.m
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/14/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "MainViewController.h"
//#import <objc/runtime.h>
//#import "UnmineableTextField.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.mainView.layer setBackgroundColor:[[NSColor colorWithRed:44/255 green:44/255 blue:44/255 alpha:0.8] CGColor]];
	[self.mainView setFrameSize:CGSizeMake(600, 380)];
	
	// set colors for unmineable text
	self.unLabel.textColor = [UtilColor colorFromHexString:@"#9CCABF"];
	self.mineableLabel.textColor = [UtilColor colorFromHexString:@"#4BCEB1"];
	
	self.searchButton.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UtilColor colorFromHexString:@"#23D160"]);
	
	// for address field, make it into layers
	self.addressField.backgroundColor = [[NSColor whiteColor] colorWithAlphaComponent:9.0f];
	self.addressField.drawsBackground = FALSE;
	self.addressField.wantsLayer = TRUE;
	CALayer *textFieldLayer = [[CALayer alloc] init];
	textFieldLayer.backgroundColor = self.addressField.backgroundColor.CGColor;
	self.addressField.layer = textFieldLayer;
	self.addressField.bordered = FALSE;
	self.textFieldCell.textColor = [NSColor blackColor];
	[self.textFieldCell setHorizontalShift:10.0f];
	
	// for textfieldcell
	self.textFieldCell.drawsBackground = FALSE;
	self.textFieldCell.focusRingType = NSFocusRingTypeNone;
	
	// change placeholder color
	// THIS WORKS!!!
	NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Your ETH address" attributes:@{NSForegroundColorAttributeName:[NSColor lightGrayColor]}];
	[str addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:37.0f] range:NSMakeRange(0, str.length)];
	self.addressField.placeholderAttributedString = str;
//	self.addressField.cell.backgroundStyle = NSBackgroundStyleEmphasized;
}

- (IBAction)callAPI:(id)sender {
	[NetworkRequest unmineableRestAPIBalanceRequestWithBaseURI:@"https://api.unminable.com/v4" coinAddress:@"0xa2530ab85557A841fe58E0d43d5aaf2D9719E323" coinType:@"ETH" callback:^(
			NSData * _Nullable data,
			NSURLResponse * _Nullable response,
			NSError * _Nullable error
		){
			@try {
				NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
				
				NSLog(@"JSON response: %@", jsonResponse);
				NSLog(@"\nBalance: %@", jsonResponse[@"data"][@"balance"]);
				[self.balanceLabel setStringValue:[NSString stringWithFormat:@"Balance: %@", jsonResponse[@"data"][@"balance"]]];
				[self.balanceLabelCell setHorizontalShift:0.0f];
				[self.balanceLabel displayIfNeeded];
				CGFloat balance =	[jsonResponse[@"data"][@"balance"] doubleValue];
				[self bitfinexAPIRequest:@"https://api-pub.bitfinex.com/v2" endpoint:@"ticker" tickerParameter:@"tETHUSD" unmineableBalance:balance];
			} @catch (NSException *exception) {
				NSLog(@"Catch block");
			}
	}];
}

- (void)bitfinexAPIRequest:(NSString *)baseURI endpoint:(NSString *)endpoint tickerParameter:(NSString *)coinTickerType unmineableBalance:(CGFloat)balance {
	[NetworkRequest bitfinexRestAPITickerTradeValueRequestWithBaseURI:baseURI tickerEndpoint:endpoint tickerParameter:coinTickerType callback:^(
			NSData * _Nullable data,
			NSURLResponse * _Nullable response,
			NSError * _Nullable error
		){
			NSLog(@"in block *********************");
			@try {
				NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
				NSLog(@"bitfinex json response: %@", jsonResponse);
				NSArray *response = (NSArray*)jsonResponse;
				NSLog(@"Array response: %@", response[0]);
				CGFloat marketValue = [response[0] doubleValue];
				CGFloat calculatedBalance = marketValue * balance;
				
				[self.balanceValueLabel setStringValue:[NSString stringWithFormat:@"Balance market value: %f", calculatedBalance]];
				[self.balanceValueLabelCell setHorizontalShift:0.0f];
				[self.balanceValueLabel displayIfNeeded];
			} @catch (NSException *exception) {
				NSLog(@"Error from bitfinex: %@", exception);
			}
	}];
}


@end
