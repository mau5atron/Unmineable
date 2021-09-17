//
//  MainViewController.m
//  Unmineable
//
//  Created by Gabriel Betancourt on 8/14/21.
//  Copyright © 2021 mau5atron. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
//#import <objc/runtime.h>
//#import "UnmineableTextField.h"

static id static_self = NULL;
static NSString *staticAddressFieldValue = @"";
// inssert pointer to the data?? for api request OR add in reference to the address value and adjust the refreshdata method to include in the api request

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// load last address if any....
	// insert function here to startup the app with the last address looked up
	[self loadLastAddress];
	
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
	
	static_self = self;
}

- (IBAction)callAPI:(id)sender {
	[self unmineableAPIRequest];
}

- (void)unmineableAPIRequest {
	// ETH Address
	[NetworkRequest unmineableRestAPIBalanceRequestWithBaseURI:@"https://api.unminable.com/v4" coinAddress:staticAddressFieldValue.length == 0 ? self.addressField.stringValue : staticAddressFieldValue coinType:@"ETH" callback:^(
			NSData * _Nullable data,
			NSURLResponse * _Nullable response,
			NSError * _Nullable error
		){
			@try {
				NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
				
				if (jsonResponse == NULL){
					NSException *jsonNullException = [NSException exceptionWithName:@"JsonResponseNullException" reason:@"Unmineable api json response was null" userInfo:NULL];
					[jsonNullException raise];
				}
				
				@try { // write the address to plist
					// write code that copies the plist file to the documents folder if it does not alread exist
					// or just write to the file
					[self writeAddressToPlist:self.addressField.stringValue];
				} @catch (NSException *exception) {
					NSLog(@"Exception: %@", exception);
				}
				
				staticAddressFieldValue = self.addressField.stringValue;
				
				NSLog(@"JSON response: %@", jsonResponse);
				NSLog(@"\nBalance: %@", jsonResponse[@"data"][@"balance"]);
				[self.balanceLabel setStringValue:[NSString stringWithFormat:@"Balance: %@ %@", jsonResponse[@"data"][@"balance"], @"ETH"]];
				[self.balanceLabelCell setHorizontalShift:0.0f];
				[self.balanceLabel displayIfNeeded];
				CGFloat balance =	[jsonResponse[@"data"][@"balance"] doubleValue];
				NSLog(@"balance Before passing to bitfinex and before conversion to CGFloat: %f", [jsonResponse[@"data"][@"balance"] doubleValue]);
				NSLog(@"balance Before passing to bitfinex: %f", balance);
				[self bitfinexAPIRequest:@"https://api-pub.bitfinex.com/v2" endpoint:@"ticker" tickerParameter:@"tETHUSD" unmineableBalance:balance];
			} @catch (NSException *exception) {
				NSLog(@"Exception unmineableAPIRequest: %@", exception);
			}
	}];
}

- (void)bitfinexAPIRequest:(NSString *)baseURI endpoint:(NSString *)endpoint tickerParameter:(NSString *)coinTickerType unmineableBalance:(CGFloat)balance {
	[NetworkRequest bitfinexRestAPITickerTradeValueRequestWithBaseURI:baseURI tickerEndpoint:endpoint tickerParameter:coinTickerType callback:^(
			NSData * _Nullable data,
			NSURLResponse * _Nullable response,
			NSError * _Nullable error
		){
			@try {
				NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
				
				if (jsonResponse == NULL){
					NSException *jsonNullException = [NSException exceptionWithName:@"bitfinexJsonAPIRequestNull" reason:@"Response from bitfinex was null." userInfo:NULL];
					[jsonNullException raise];
				}
				
				NSLog(@"bitfinex json response: %@", jsonResponse);
				NSArray *response = (NSArray*)jsonResponse;
				NSLog(@"Array response: %@", response[0]);
				CGFloat marketValue = [response[0] doubleValue];
				CGFloat calculatedBalance = marketValue * balance;
				
				[self.balanceValueLabel setStringValue:[NSString stringWithFormat:@"Market Value: $%f USD", calculatedBalance]];
				NSLog(@"Before sending value: %f", balance);
				[AppDelegate getApiCallFromMainBalance:balance withMarketValue:calculatedBalance];
				[self.balanceValueLabelCell setHorizontalShift:0.0f];
				[self.balanceValueLabel displayIfNeeded];
			} @catch (NSException *exception) {
				NSLog(@"Error from bitfinex: %@", exception);
			}
	}];
}

// implement single function that can have multiple actions based on enum value
// such as writing to plist, loading from plist, etc

- (void)loadLastAddress {
	// NSLog(@"Load last address here");
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE);
	
	NSString *documentsPath = [paths objectAtIndex:0];
	NSString *addressPlistPath = [documentsPath stringByAppendingPathComponent:@"address_list.plist"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ( [fileManager fileExistsAtPath:addressPlistPath] ){
		// if the file exists, then do load
		NSMutableDictionary *addressPlistContents = [[NSMutableDictionary alloc] initWithContentsOfFile:addressPlistPath];
		if ( [addressPlistContents[@"last_address_searched"] length] > 0 ){
			//NSLog(@"Dictionary from load: %@", addressPlistContents[@"last_address_searched"]);
			self.addressField.stringValue = addressPlistContents[@"last_address_searched"];
		}
	}
}

- (void)writeAddressToPlist:(NSString*)address {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE);
	
	NSString *documentsPath = [paths objectAtIndex:0];
	NSString *addressPlistPath = [documentsPath stringByAppendingPathComponent:@"address_list.plist"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSError *addressPlistError;
	
	if ( ![fileManager fileExistsAtPath:addressPlistPath] ){
		NSString *mainBundle = [[NSBundle mainBundle] pathForResource:@"address_list" ofType:@"plist"];
		[fileManager copyItemAtPath:mainBundle toPath:addressPlistPath error:&addressPlistError];
	}
	
	NSMutableDictionary *addressPlistContents = [[NSMutableDictionary alloc] initWithContentsOfFile:addressPlistPath];
	
	addressPlistContents[@"last_address_searched"] = self.addressField.stringValue;
	[addressPlistContents writeToFile:addressPlistPath atomically:TRUE];
	NSLog(@"addressPistContents: %@", addressPlistContents);
}

+ (void)refreshData {
	// need to pass block here
	[static_self unmineableAPIRequest];
}

@end
